require 'pry'
class Minefield
  attr_reader :row_count, :column_count, :mine_count
  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @empty_cells = (column_count * row_count) - mine_count
    @minefield = {}
    @is_a_mine = false
    @all_cells_cleared = false
    @clear_count = 0

  for y in 0..@column_count
  for x in 0..@row_count
    @minefield[[x,y]] = {clear: false, mine: false}
  end
 end

  @mine_count.times do
    mine_x = Random.rand(@column_count)
    mine_y = Random.rand(@row_count)
    @minefield[[mine_x,mine_y]] = {clear: false, mine: true}
  end
end

# PROBLEM: the cells are all being uncovered even if there are mines. if there are, they shouldn't be uncovered

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    if @minefield[[row,col]][:clear] == false
      false
    else
    true
    end
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    if @minefield[[row,col]][:clear] = false
      @minefield[[row,col]][:clear] = true
      @clear_count +=1
    end

#if cell isn't 0,0, clear the adjecent upper left cell
  if row != 0 && col != 0
    @minefield[[row-1,col-1]][:clear] = true
    @clear_count +=1
  end
#if cell isn't in the top row, clear the adjcent above and upper right cells
  if row != 0
    @minefield[[row-1, col]][:clear] = true
    @minefield[[row-1, col +1]][:clear] = true
    @clear_count +=2
  end
#if it isn't in the left-most column, clear the adjecent left and the bottom left
  if col !=0
    @minefield[[row +1, col-1]][:clear] = true
    @minefield[[row +0, col -1]][:clear] = true
    @clear_count +=2
  end

#if cell isn't in the last cell, clear the bottom right cell
  if row!= @row_count && col != @column_count
    @minefield[[row +1,col +1]][:clear] = true
    @clear_count +=1
  end

#if cell isn't in the bottom row, clear the adjacent bottom cell
  if row!=row_count
   @minefield[[row +1, col]][:clear] = true
   @clear_count +=1
  end

#if cell isn't in the right most column, clear adjacent right cell
  if col != column_count
    @minefield[[row, col + 1]][:clear] = true
    @clear_count +=1
  end
end

# Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    @minefield.each do |key,value|
      if value[:clear] == true && value[:mine] = true
        true
      else
        false
      end
    end
  end
  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.

  def all_cells_cleared?(row,col)
    if @minefield[[row,col]][:clear] = false
      false
    else
      true
    end
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    count = 0

    if row!=0 && col != 0
      if @minefield[[row -1, col-1]][:mine] == true
       count +=1
      end
    end

   if col != 0
      if @minefield[[row + 1, col-1]][:mine] == true
        count +=1
      end
      if @minefield[[row + 1, col +1]][:mine] == true
        count +=1
    end
   end

  if row!=0
    if @minefield[[row-1, col][:mine]] == true
        count +=1
    end
    if @minefield[[row -1, col + 1]][:mine] == true
      count +=1
    end
  end

 if row != @row_count
    if @minefield[[row +1, col]][:mine] == true
       count +=1
    end
  end

 if row!= @row_count && col != @column_count
    if @minefield[[row+1, col+ 1]][:mine] == true
      count +=1
    end
  end

  if col != @column_count
    if @minefield[[row + 0, col + 1]][:mine] == true
      count +=1
    end
  end

  count
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    if @minefield[[row,col]][:mine] == true
      true
    else
     false
    end
  end
# cell_cleared?(3,7)
end

