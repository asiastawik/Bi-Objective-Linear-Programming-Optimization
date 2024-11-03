# Bi-Objective Linear Programming Optimization

## Project Overview

This project focuses on solving a bi-objective linear programming problem using various optimization techniques in MATLAB. The objective is to identify Pareto optimal solutions through different methods, analyze the ideal and nadir points, and visualize the Pareto front.

## Problem Description

### Objective Functions

The bi-objective linear programming problem is defined as follows:

1. **Maximize**:  
   \[ g_1 = 3x_1 + 5x_2 \]

2. **Maximize**:  
   \[ g_2 = x_1 \]

## Objectives

The project addresses the following questions:

1. **Weighted Average Method**: Employ the weighted average method to identify a Pareto optimal solution with weights \( w_1 = 0.7 \) and \( w_2 = 0.3 \).
2. **Lexicographic Method**: Use the lexicographic method to find a Pareto optimal solution by considering all possible combinations of priorities between the two objective functions.
3. **Identify Ideal and Nadir Points**: Determine the ideal and nadir points based on the objectives.
4. **Unweighted Min-Max Formulation**: Apply the unweighted min-max formulation from the ideal point to identify a Pareto optimal solution.
5. **Generate and Plot Pareto Front**: Create a visual representation of the Pareto front to illustrate the trade-offs between the objectives.

## Methodology

### 1. Weighted Average Method

This method involves assigning weights to each objective function and solving the resulting single-objective linear program. By varying the weights, different Pareto optimal solutions can be identified.

### 2. Lexicographic Method

In this approach, one objective function is prioritized over the other. The problem is solved multiple times, changing the order of importance, to identify all possible Pareto optimal solutions.

### 3. Ideal and Nadir Points

- **Ideal Point**: This is the maximum achievable value for each objective function, representing the best possible scenario.
- **Nadir Point**: This is the worst value for each objective function that is still part of the Pareto optimal set.

### 4. Unweighted Min-Max Formulation

This method focuses on minimizing the maximum deviation from the ideal point. The optimization problem is reformulated to identify a Pareto optimal solution based on this criterion.

### 5. Pareto Front Visualization

The Pareto front represents the set of all Pareto optimal solutions, illustrating the trade-offs between the two objectives. The front will be plotted using MATLAB's visualization tools.

## Implementation in MATLAB

The project utilizes MATLAB to implement the optimization techniques, including the formulation of linear programs, solving them, and generating visual outputs. Key MATLAB functionalities and optimization toolboxes are leveraged to execute the various methods outlined above.

## Expected Outcomes

The project aims to provide:

- A set of Pareto optimal solutions identified through different methodologies.
- The ideal and nadir points for the objectives.
- A visual representation of the Pareto front that highlights the trade-offs between the two objective functions.

## Future Enhancements

- **Sensitivity Analysis**: Incorporate sensitivity analysis to explore how changes in the coefficients of the objective functions and constraints affect the Pareto optimal solutions.
- **Extended Objective Functions**: Expand the problem to include more than two objectives and apply multi-objective optimization techniques.
- **Interactive Visualization**: Develop interactive tools for users to explore the Pareto front and understand the implications of different trade-offs.

## Conclusion

This project demonstrates the application of various optimization methods to solve a bi-objective linear programming problem, providing valuable insights into the trade-offs between conflicting objectives. Through the identification of Pareto optimal solutions and visualization of the Pareto front, the project highlights the importance of multi-objective optimization in decision-making processes.
