--[[-----------------------------------------------
    AMatrix:MatrixFromTbl(tbl, rows, columns)
-----------------------------------------------]]--
-- Turns a straight table into a matrix defined by rows and columns input
-- example input table ({{1,2,3}, {4,5,6}, {7,8,9}}, 3, 3)
-- tbl output:
--[[
	1 2 3 - row1
	4 5 6 - row2
	7 8 9 - row3
--]]
AMatrix = {}

function AMatrix:new(tbl)
	local mtx = {}
	for _, v in pairs (tbl) do
		mtx[#mtx+1] = v
	end

	setmetatable(mtx, AMatrix)
	return mtx
end

function AMatrix:PrintMatrix()
	for i = 1, #self do
		local row = self[i]
		local rowString = "| "
		for j = 1, #row do
			rowString = rowString .. row[j] .. " "
		end
		print(rowString .. "|")
	end
end

function AMatrix:Get(row, column)
	return self[row][column]
end

function AMatrix:__tostring()
	local str = ""
	for i = 1, #matrix do
		local row = matrix[i]
		for j = 1, #row do
			str = str .. row[j] .. " "
		end
	end
	return str
end

function MatrixFromTbl(tbl, rows, columns)
	local mtx = {}
    if (rows * columns) < #tbl then
        return
    end

    for i = 1, rows do
        mtx[i] = {}
        for j = 1, columns do
            mtx[i][j] = tbl[(i-1)*columns + j]
        end
    end

	return AMatrix:new(mtx) -- returns the table turned into a matrix table... (its just a 3d table basically lol)
end

--[[-----------------------------------------------
    AMatrix:MatrixToTable()
-----------------------------------------------]]--
-- Turns a matrix table into a normal table
function AMatrix:MatrixToTable()
    local tbl = {}
    for i = 1,#self do
        for j = 1,#self[i] do
            tbl[#tbl+1] = self[i][j]
        end
    end
    return tbl
end

--[[-----------------------------------------------
    AMatrix:Add(m1)
-----------------------------------------------]]--
-- Adds two matrix tables toghether performing a matrix addition
function AMatrix:Add(m1)
    local mtx = {}
	for i = 1,#self do
		local m3i = {}
		mtx[i] = m3i
		for j = 1,#self[1] do
			m3i[j] = self[i][j] + m1[i][j]
		end
	end
	return self:new(mtx)
end

--[[-----------------------------------------------
    AMatrix:Sub(m1)
-----------------------------------------------]]--
-- Subtracts two matrix tables toghether performing a matrix subtraction
function AMatrix:Sub(m1)
    local mtx = {}
	for i = 1,#self do
		local m3i = {}
		mtx[i] = m3i
		for j = 1,#self[1] do
			m3i[j] = self[i][j] - m1[i][j]
		end
	end
	return self:new(mtx)
end

--[[-----------------------------------------------
    AMatrix:Mul(m1)
-----------------------------------------------]]--
-- Multiplys two matrix tables toghether performing a matrix multiplication
function AMatrix:Mul(m1)
    local mtx = {}
	for i = 1,#self do
		mtx[i] = {}
		for j = 1,#m1[1] do
			local num = self[i][1] * m1[1][j]
			for n = 2,#self[1] do
				num = num + self[i][n] * m1[n][j]
			end
			mtx[i][j] = num
		end
	end
	return self:new(mtx) -- return the table in matrix form otherwise you cant use printmatrix and stuff on the results.
end

--[[-----------------------------------------------
    AMatrix:Div(m1)
-----------------------------------------------]]--
-- Divides two matrix tables by each other.
function AMatrix:Div(m1)
    local num_rows = #self
    local num_cols = #self[1]
    if num_rows ~= #m1 or num_cols ~= #m1[1] then
        return
    end
    local result = {}
    for i = 1, num_rows do
        result[i] = {}
        for j = 1, num_cols do
            result[i][j] = self[i][j] / m1[i][j]
        end
    end
    return self:new(result)
end

setmetatable(AMatrix, {__call = AMatrix.new})
AMatrix.__index = AMatrix