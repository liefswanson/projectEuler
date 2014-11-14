--Copyright (C) 2014 Lief Swanson

--This program is free software; you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation; either version 2 of the License, or
--(at your option) any later version.

--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--GNU General Public License for more details.

--You should have received a copy of the GNU General Public License
--along with this program; if not, write to the Free Software
--Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

--Author: Lief Swanson
--URL: https://github.com/liefswanson

import System.Environment

main :: IO() 
main = do
     filePath:args <- getArgs
     unparsed <- readFile filePath
     let parsed = lines unparsed
     let integers = map read parsed :: [Integer]
     let output = show $ sum integers
     putStrLn $ take ( digits args output) output

digits :: [String] -> String -> Int
digits [] number = length number
digits (x:_) _ = read $ x :: Int

