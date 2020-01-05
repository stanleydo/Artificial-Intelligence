from math import log10

from typing import List, Optional


def display_solution(solution: List[int], assignments, time: float = None, solution_nbr: Optional[int] = None) -> None:
    # solution is a list of col variables, i.e., for each column, the row in which the queen appears.
    if len(solution) <= 50:
        solution = {row: col for (col, row) in enumerate(solution)}
        sol = sorted([(r, c) for (r, c) in solution.items()])
        # To print the board must convert solution to a list of row variables,
        # i.e., for each row, the column in which the queen appears.
        placement_vector = [c for (_, c) in sol]
        solution_display = layout(placement_vector)
        if solution_nbr:
            print(f'\n{solution_nbr}.', end='')
        print(f'\n{solution_display}')
    if time:
        print(f'\nFound a solution after {assignments} assignments.')
        print(f'Time: {time} sec.')


def layout(placement_vector: [int]) -> str:
    """
        Format the placement_vector for display.
        The placement_vector is a series of col numbers, one for each row.
    """
    board_size = len(placement_vector)
    # Generate the column headers.
    col_hdrs = ' '*(4+int(log10(board_size))) + \
        ' '.join([f'{n:2}' for n in range(1, board_size+1)]) + '  col#\n'
    display = col_hdrs + '\n'.join([one_row(r, c, board_size)
                                    for (r, c) in enumerate(placement_vector)])
    return display


def one_row(row: int, col: int, board_size: int) -> str:
    """ Generate one row of the board. """
    # (row, col) is the queen position expressed in 0-based indices for this row.
    # Since we want 1-based labels increment row and col by 1.
    return f'{space_offset(row+1, board_size)}{row+1})  ' + \
           f'{" . "*col} Q {" . "*(board_size-col-1)} {space_offset(col+1, board_size)}({col+1})'


def space_offset(n: int, board_size: int) -> str:
    return " "*(int(log10(board_size)) - int(log10(n)))
