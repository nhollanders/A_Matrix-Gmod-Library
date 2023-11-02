# Gmod-Matrix-Library

## Installation

To install drag the downloaded repo into your GarrysMod/garrysmod folder.

The folder should join with the already existing lua folder.

## Usage

Using this is very simple as explained below
```
local matrixObject = AMatrix({1,2,3},{4,5,6})
local multiplyMatrix = AMatrix({1,2,3},{4,5,6})

local multipliedOutput = matrixObject:Mul(multiplyMatrix)

multipliedOutput:PrintMatrix()
```
This example makes a 3x2 matrix row one containing 1, 2 and 3, and so on.
More advanced usage is shown within the render_test.lua file which uses the matrix library to project a cube onto a vgui screen using points simulating a very basic 3d projection along with adding perspective.
