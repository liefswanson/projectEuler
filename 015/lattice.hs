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
  h:w:[] <- getArgs
  let height = read h ::Integer
  let width = read w ::Integer
  putStrLn $ show $ lattice height width

lattice :: Integer -> Integer -> Integer
lattice height width = (product [height+1..height+width]) `div` (product [1..height])
