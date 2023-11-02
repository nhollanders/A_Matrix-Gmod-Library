local sin, cos = math.sin, math.cos

local cube = {
    {-1,-1,-1},
    {1,-1,-1},
    {1,1,-1},
    {-1,1,-1},
    {-1,-1,1},
    {1,-1,1},
    {1,1,1},
    {-1,1,1},
}

local BLACK = Color(0, 0, 0) -- background
local WHITE = Color(255, 255, 255) -- edges
local RED = Color(255, 0, 0) -- verts

SCREENWIDTH, SCREENHEIGHT = 600, 600

local mainScreen = vgui.Create("DFrame")
mainScreen:SetSize(SCREENWIDTH, SCREENHEIGHT)
mainScreen:Center()
mainScreen:SetTitle("3D Cube")
mainScreen:MakePopup()

local size = 100 -- simple 2D object scaling
local moveX = 200
local moveY = 200
local distance = 2

local function DrawPoint(x, y)
    surface.DrawCircle(x, y, 5, RED)
end

local function connect(i, j, tbl)
    surface.SetDrawColor(WHITE)
    surface.DrawLine(tbl[i][1], tbl[i][2], tbl[j][1], tbl[j][2])
end

mainScreen.Paint = function(self, w, h)
    local projectedPoints = {}
    draw.RoundedBox(0, 0, 0, w, h, BLACK)
    local IV = CurTime()

    for i = 1, #cube do

        local rotationMatrixX = AMatrix({{1, 0, 0}, {0, cos(IV), -sin(IV)}, {0, sin(IV), cos(IV)}})
        local rotationMatrixY = AMatrix({{cos(IV), 0, sin(IV)}, {0,1,0}, {-sin(IV), 0, cos(IV)}})
        local rotationMatrixZ = AMatrix({{cos(IV), -sin(IV), 0}, {sin(IV), cos(IV), 0}, {0,0,1}})

        local pointData = cube[i]
        local rotatedMatrix = AMatrix({pointData}):Mul(rotationMatrixY) -- you must rotate it before projection to get correct outputs.
        rotatedMatrix = rotatedMatrix:Mul(rotationMatrixX)
        rotatedMatrix = rotatedMatrix:Mul(rotationMatrixZ)


        local z = 1/(distance - rotatedMatrix:Get(1,3))
        local projectionMatrix = AMatrix({{1,0,0}, {0,1,0}, {0,0,0}})

        local projectedMatrix = rotatedMatrix:Mul(projectionMatrix) -- once the points are correctly rotated you can project them into a 2d screen.
        local x = projectedMatrix:Get(1,1) * size + moveX
        local y = projectedMatrix:Get(1,2) * size + moveY
        projectedPoints[i] = {x, y}
        DrawPoint(x, y)

    end

    connect(1, 2, projectedPoints)
    connect(2, 3, projectedPoints)
    connect(3, 4, projectedPoints)
    connect(4, 1, projectedPoints)

    connect(5, 6, projectedPoints)
    connect(6, 7, projectedPoints)
    connect(7, 8, projectedPoints)
    connect(8, 5, projectedPoints)

    connect(1, 5, projectedPoints)
    connect(2, 6, projectedPoints)
    connect(3, 7, projectedPoints)
    connect(4, 8, projectedPoints)
    
end
