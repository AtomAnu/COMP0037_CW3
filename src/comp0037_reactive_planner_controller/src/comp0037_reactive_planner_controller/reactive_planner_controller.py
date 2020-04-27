# This class manages the key logic for the reactive planner and
# controller. This monitors the the robot motion.

import rospy
import threading
from cell import CellLabel
from planner_controller_base import PlannerControllerBase
from comp0037_mapper.msg import *
from comp0037_reactive_planner_controller.aisle import Aisle

class ReactivePlannerController(PlannerControllerBase):

    def __init__(self, occupancyGrid, planner, controller):
        PlannerControllerBase.__init__(self, occupancyGrid, planner, controller)
        
        self.mapUpdateSubscriber = rospy.Subscriber('updated_map', MapUpdate, self.mapUpdateCallback)
        self.gridUpdateLock =  threading.Condition()
        self.aisleToDriveDown = None
        self.waitTime = -2

    def mapUpdateCallback(self, mapUpdateMessage):

        # Update the occupancy grid and search grid given the latest map update
        self.gridUpdateLock.acquire()
        self.occupancyGrid.updateGridFromVector(mapUpdateMessage.occupancyGrid)
        self.planner.handleChangeToOccupancyGrid()
        self.gridUpdateLock.release()

        # If we are not currently following any route, drop out here.
        if self.currentPlannedPath is None:
            return

        self.checkIfPathCurrentPathIsStillGood()

    def checkIfPathCurrentPathIsStillGood(self):

        # This methods needs to check if the current path, whose
        # waypoints are in self.currentPlannedPath, can still be
        # traversed
                
        # If the route is not viable any more, call
        # self.controller.stopDrivingToCurrentGoal()
        for waypoint in self.currentPlannedPath.waypoints:
            if self.planner.searchGrid.getCellFromCoords(waypoint.coords).label == CellLabel.OBSTRUCTED:
                self.controller.stopDrivingToCurrentGoal()

        return

    # Choose the first aisle the robot will initially drive down.
    # This is based on the prior.
    def chooseInitialAisle(self, startCellCoords, goalCellCoords):
        best_aisle = Aisle.A
        for item in Aisle:
            best_aisle_path_cost = self.planPathToGoalViaAisle(startCellCoords, goalCellCoords, best_aisle).travelCost
            aisle_path_cost = self.planPathToGoalViaAisle(startCellCoords, goalCellCoords, item).travelCost
            if item.name = 'B': aisle_path_cost += waiting_time*0.8 
            print('Path cost of '+item.name+' is {}'.format(aisle_path_cost))
            if aisle_path_cost <= best_aisle_path_cost:
                best_aisle = item
            
        return best_aisle

    # Choose the subdquent aisle the robot will drive down
    def chooseAisle(self, startCellCoords, goalCellCoords):
        return Aisle.E

    # Return whether the robot should wait for the obstacle to clear or not.
    def shouldWaitUntilTheObstacleClears(self, startCellCoords, goalCellCoords):
        
        startCell = self.planner.searchGrid.getCellFromCoords(startCellCoords)
        distance = []
        
        # Find the minimum distance between planned path waypoints and the current position.
        for waypoint in self.currentPlannedPath.waypoints:
            distance.append(self.planner.computeLStageAdditiveCost(startCell, waypoint))

        costRemained = min(distance)
        currentWaypointIndex = distance.index(costRemained)
        
        # Calculate the cost remained
        for i in range(currentWaypointIndex, len(self.currentPlannedPath.waypoints)-1):
            costRemained += self.planner.computeLStageAdditiveCost(self.currentPlannedPath.waypoints[i], self.currentPlannedPath.waypoints[i+1])
        
        costRemained += self.waitTime * 2
        print "Cost remained is: " + str(costRemained)

        # Replan the path on other four aisles and choose the one with the lowest cost.
        costReplan = []
        aisleReplan = []
        for aisle in Aisle:
            if aisle is not self.aisleToDriveDown:
                # print "Aisle is: " + str(aisle)         
                pathReplan = self.planPathToGoalViaAisle(startCellCoords, goalCellCoords, aisle)
                costReplan.append(pathReplan.travelCost)
                aisleReplan.append(aisle)
        
        chosenIndex = costReplan.index(min(costReplan))
        chosenAisle = aisleReplan[chosenIndex]
        chosenPathCost = min(costReplan)

        print "Cost replan is: " + str(chosenPathCost)
        print "Aisle replan is: " + str(chosenAisle)

        if chosenPathCost > costRemained:
            return True
        else:
            self.aisleToDriveDown = chosenAisle
            return False

    # This method will wait until the obstacle has cleared and the robot can move.
    def waitUntilTheObstacleClears(self):
        
        # Stop the robot.
        self.controller.stopRobot()
        flag = False
        
        # while loop until the obstacle disappear.
        while True:
            # When no waypoint in the planned path is obstacle, then the obstacle disappear.
            for waypoint in self.currentPlannedPath.waypoints:
                if self.planner.searchGrid.getCellFromCoords(waypoint.coords).label == CellLabel.OBSTRUCTED:
                    flag = True
                    break
            if not flag:
                return
    
    # Plan a path to the goal which will go down the designated aisle. The code, as
    # currently implemented simply tries to drive from the start to the goal without
    # considering the aisle.
    def planPathToGoalViaAisle(self, startCellCoords, goalCellCoords, aisle):

        # Note that, if the robot has waited, it might be tasked to drive down the
        # aisle it's currently on. Your code should handle this case.
        if self.aisleToDriveDown is None:
            self.aisleToDriveDown = aisle

        # Implement your method here to construct a path which will drive the robot
        # from the start to the goal via the aisle.

        # coordinates of the middle destinations within aisles (left corner x, right corner x, corner y).
        switcher = {
            Aisle.A: (20, 32, 22),
            Aisle.B: (37, 48, 22),
            Aisle.C: (53, 64, 22),
            Aisle.D: (69, 79, 22),
            Aisle.E: (84, 95, 22)
        }

        mid = switcher.get(aisle, None)

        if mid == None:
            rospy.logwarn("Wrong aisle input")
            return None
        elif startCellCoords[0] > mid[0] and startCellCoords[0] < mid[1]:
            chosenAisle = (startCellCoords[0], mid[2])
        elif abs(startCellCoords[0] - mid[0]) > abs(startCellCoords[0] - mid[1]):
            chosenAisle = (mid[1], mid[2])
        else:
            chosenAisle = (mid[0], mid[2])

        pathToMidFound = self.planner.search(startCellCoords, chosenAisle)

        # If we can't reach the goal, give up and return
        if pathToMidFound is False:
            rospy.logwarn("Could not find a path to the aisle at (%d, %d)", \
                            mid[0], mid[1])
            return None
        
        self.planner.setShowGraphics(False)

        # Extract the path
        currentPlannedPath = self.planner.extractPathToGoal()

        pathToGoalFound = self.planner.search(chosenAisle, goalCellCoords)

        # If we can't reach the goal, give up and return
        if pathToGoalFound is False:
            rospy.logwarn("Could not find a path to the goal at (%d, %d)", \
                            goalCellCoords[0], goalCellCoords[1])
            return None

        # Combine two paths.
        currentPlannedPath.addToEnd(self.planner.extractPathToGoal())

        # Reset start and goal for the combined path.
        self.planner.setShowGraphics(True)
        self.planner.start = self.planner.searchGrid.getCellFromCoords(startCellCoords)
        self.planner.goal = self.planner.searchGrid.getCellFromCoords(goalCellCoords)
        self.planner.resetGraphics()

        # Draw the combined path.
        self.planner.searchGridDrawer.update()
        self.planner.searchGridDrawer.drawPathGraphicsWithCustomColour(currentPlannedPath, 'yellow')
        self.planner.searchGridDrawer.waitForKeyPress()

        print "Combined path travel cost = " + str(currentPlannedPath.travelCost)

        return currentPlannedPath

    # This method drives the robot from the start to the final goal. It includes
    # choosing an aisle to drive down and both waiting and replanning behaviour.
    # Note that driving down an aisle is like introducing an intermediate waypoint.

    def driveToGoal(self, goal):

        # Get the goal coordinate in cells
        goalCellCoords = self.occupancyGrid.getCellCoordinatesFromWorldCoordinates((goal.x,goal.y))

        # Set the start conditions to the current position of the robot
        pose = self.controller.getCurrentPose()
        start = (pose.x, pose.y)
        startCellCoords = self.occupancyGrid.getCellCoordinatesFromWorldCoordinates(start)

        # Work out the initial aisle to drive down
        aisleToDriveDown = self.chooseInitialAisle(startCellCoords, goalCellCoords)

        # Reactive planner main loop - keep iterating until the goal is reached or the robot gets
        # stuck.
        
        while rospy.is_shutdown() is False:

            # Plan a path from the robot's current position to the goal. This is called even
            # if the robot waited and used its existing path. This is more robust than, say,
            # stripping cells from the existing path.           
            
            print 'Planning a new path: start=' + str(start) + '; goal=' + str(goal)
            
            # Plan a path using the current occupancy grid
            self.gridUpdateLock.acquire()
            self.currentPlannedPath = self.planPathToGoalViaAisle(startCellCoords, goalCellCoords, aisleToDriveDown)
            self.gridUpdateLock.release()

            # If we couldn't find a path, give up
            if self.currentPlannedPath is None:
                return False

            # Drive along the path towards the goal. This returns True
            # if the goal was successfully reached. The controller
            # should stop the robot and return False if the
            # stopDrivingToCurrentGoal method is called.
            goalReached = self.controller.drivePathToGoal(self.currentPlannedPath, \
                                                          goal.theta, self.planner.getPlannerDrawer())

            rospy.logerr('goalReached=%d', goalReached)

            # If we reached the goal, return
            if goalReached is True:
                return True

            # An obstacle blocked the robot's movement. Determine whether we need to
            # wait or replan.

            # Figure out where we are
            pose = self.controller.getCurrentPose()
            start = (pose.x, pose.y)
            startCellCoords = self.occupancyGrid.getCellCoordinatesFromWorldCoordinates(start)

            # See if we should wait
            waitingGame = self.shouldWaitUntilTheObstacleClears(startCellCoords, goalCellCoords)

            # Depending upon the decision, either wait or determine the new aisle
            # we should drive down.
            if waitingGame is True:
                self.waitUntilTheObstacleClears()
            else:
                #aisleToDriveDown = self.chooseAisle(startCellCoords, goalCellCoords)
                aisleToDriveDown = self.aisleToDriveDown

        return False
            
            
