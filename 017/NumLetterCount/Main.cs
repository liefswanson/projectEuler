//Copyright (C) 2014 Lief Swanson

//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with this program; if not, write to the Free Software
//Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

//Author: Lief Swanson
//URL: https://github.com/liefswanson

using System;
using EulerSeventeen;

public class MainProgram {

	public static void Main(string[] args) {

		if (args.Length < 1) {
			
			Console.WriteLine("please specify a number to go up to.");
			return;
		}
		
		ulong high;
		ulong low;
		try {

			if (args.Length == 1) {
				low = 1;
				high = Convert.ToUInt64(args[0]);
			} else {
				low = Convert.ToUInt64(args[0]);
				high = Convert.ToUInt64(args[1]);
			}
			
		} catch(Exception ex) {

			Console.WriteLine(ex.ToString());
			return;

		}
		
		ulong tally = 0;
		EnglishNumber current;
		string temp;
		for (ulong i = low; i <= high; i++) {
			current = new EnglishNumber(i);
			//Console.WriteLine(i);
			Console.WriteLine(current);
			temp = current.english.Replace(" ", "").Replace("-", "");
			tally += (ulong)temp.Length;
		}
		System.Console.WriteLine("The sum of the lengths of all numbers in english from {0} to {1} is {2}",low ,high, tally);
	}
}
