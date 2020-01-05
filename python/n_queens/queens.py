# queens.py
# From Classic Computer Science Problems in Python Chapter 3
# Copyright 2018 David Kopec
#
# Modified by Russ Abbott (July/October, 2019)
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from copy import copy
from timeit import default_timer as timer
from typing import Dict, List, Optional, Set

from csp import all_different, CSP
from queens_display import display_solution


def n_queens_constraint(board) -> bool:
    board_size = len(board)
    up_down_pairs: List[List[int, int]] = [
        [board[i] - i, board[i] + i]
        for i in range(board_size) if board[i] is not None
    ]
    [l1, l2] = zip(*up_down_pairs)
    (up_diagonal, down_diagonal) = (list(l1), list(l2))

    up_diagonal_alt = [board[i] -
                       i for i in range(board_size) if board[i] is not None]
    down_diagonal_alt = [board[i] +
                         i for i in range(board_size) if board[i] is not None]

    assert up_diagonal == up_diagonal_alt and down_diagonal == down_diagonal_alt, \
        f'diagonals differ: up: {up_diagonal} != {up_diagonal_alt} or down: {down_diagonal} !={down_diagonal_alt}'
    return all_different(board) and all_different(up_diagonal) and all_different(down_diagonal)


# noinspection PyUnusedLocal
def propagate_column_constraint(_selected_col, selected_row, domains: Dict[int, Set[int]]) -> Dict[int, Set[int]]:
    reduced_domains: Dict[int, Set[int]] = copy(domains)
    # Prevent other columns from putting a queen in this queen's selected_row
    """ Your code here """
    # Propgate_column_constraint will handle the vertical and horizontal domain reduction
    # The domain is a dictionary {'column number' : set(rows)}
    # so, remove the selected_col from all domains
    # for every v in the dictionary domains, get domains[v] and remove the selected_row from it
    reduced_domains = {
        v: (domains[v] - {selected_row}) for v in domains}

    # Removes all possible row entries for the selected column
    reduced_domains[_selected_col] = set()

    return reduced_domains


# noinspection PyUnusedLocal
def propagate_diagonals_constraint(selected_col, selected_row, domains: Dict[int, Set[int]]) -> Dict[int, Set[int]]:
    reduced_domains: Dict[int, Set[int]] = copy(domains)
    # Prevent other columns from putting a queen in this queen's diagonals
    """ Your code here """

    # Handles right side diagonals - columns increase by 1, row increases by 1 and decreases by 1
    # Start with a counting variable
    rows_expanded = 1
    # Loop for x in range(start, end, step)
    # Start from the selected_column and end at len(domains)-1 (because next_col will be n)
    for x in range(selected_col, len(domains) - 1, 1):
        # Specify next column
        next_col = x + 1
        # Specify top right row as selected_row - rows_expanded.
        # If the selected row - rows_expanded is greater than or equal to 0, it has not yet reached the top edge
        top_right_row = (
            selected_row - rows_expanded) if (selected_row - rows_expanded) >= 0 else None
        # Specify bottom right row as selected_row - rows_expanded.
        # If the selected row + rows_expanded < len(domains) - 1, it has not yet reached the bottom.
        bottom_right_row = (
            selected_row + rows_expanded) if (selected_row + rows_expanded) >= 0 else None
        rows_expanded += 1
        # Remove the top_right_row square and bottom_right_row square from the domains of the next_column
        reduced_domains[next_col] = reduced_domains[next_col] - \
            {top_right_row, bottom_right_row}

    # Handles left side diagonals - columns decrease by 1, row increases by 1 and decreases by 1
    # Start with a counting variable
    rows_expanded = 1
    # Loop for x in range(start, end, step)
    # Start from the selected_column and end at 0, since we are moving left of the selected column
    for x in range(selected_col, 0, -1):
        next_col = x - 1
        # Specify the top left row as selected_row - rows_expanded
        # If the selected_row +/- rows_expanded is >= 0, that means it has not yet reached an edge
        top_left_row = (
            selected_row - rows_expanded) if (selected_row - rows_expanded) >= 0 else None
        # Specify the bottom left row as selected_row + rows_expanded
        bottom_left_row = (
            selected_row + rows_expanded) if (selected_row + rows_expanded) >= 0 else None
        rows_expanded += 1
        # Remove the top_left_row square and bottom_left_row square from the domains of the next_column
        reduced_domains[next_col] = reduced_domains[next_col] - \
            {top_left_row, bottom_left_row}

    return reduced_domains


def run_n_queens(board_size, first_fail=True, propagation=True, central_domain_selection=True):

    # The board is represented as a list. Each element represents the position, i.e., row, of the queen in that column.
    # (The program uses 0-based indexing since it's basic to Python. The results are labelled with 1-based indexing.)
    #
    # So board = [1, 3, 0, 2] means:
    #                                  0 1 2 3
    #                               0) . . Q .
    #                               1) Q . . .
    #                               2) . . . Q
    #                               3) . Q . .
    #
    # This model of the problem ensures that each column has exactly one queen--or None if no queen is assigned
    # to that column.

    # Intially, the board is empty. The board will substitute for the assignment dictionary.
    # A value of 0 means that no assignment has been made.
    board: List[Optional[int]] = [None]*board_size
    # Each board position has the same domain.
    # Note that instead of variable names we are using numbers as variables.
    board_size = len(board)
    common_domain = set(range(board_size))
    domains = {v: common_domain for v in range(board_size)}

    # Set assignment_limit to 0 to turn off tracing. A positive number indicates
    # the number of assignments to allow (and to display) before quitting.
    assignment_limit = 0

    # Create the CSP object
    csp: CSP[int, int] = CSP(board_size, assignment_limit,
                             propagation, first_fail, central_domain_selection)
    csp.add_constraint(n_queens_constraint)
    csp.add_propagator(propagate_column_constraint)
    csp.add_propagator(propagate_diagonals_constraint)

    timer_start = timer()
    solution = csp.complete_the_assignment(board, domains)
    assignments = csp.assignment_count
    if solution:
        display_solution(solution, assignments,
                         round(timer() - timer_start, 3))
    else:
        print(f'\nNo solution after {assignments} assignments.')


if __name__ == "__main__":

    run_n_queens(300, propagation=True, first_fail=True,
                 central_domain_selection=True)
