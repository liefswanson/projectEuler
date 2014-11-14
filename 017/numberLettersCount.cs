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
using System.Collections.Generic;

//cases for numbers up to Quintillion
//Thousand
//Million
//Billion
//Trillion
//Quadrillion
//Quintillion

public class EnglishNumber {
	
	//eg: of parse technique
	//3754254582340
	//[3,754,254,582,340]
	//[[3,0],[7,54],[2,54],[5,82],[3,40]]
	//3 trillion, seven hundred and fifty-four billion, two hundred and fifty-four million, five hundred and eighty-two thousand, three hundred and forty

	//while temp > 0
	//append temp % 1000
	//temp / 1000
}

public class Program {

	public static void Main(string[] args) {

		if (args.Length < 1) {
			
			System.Console.WriteLine("please specify a number to go up to.");
			return;
		}
		
		ulong high;
		ulong low;
		try {

			if (args.Length == 1) {
				low = 1;
				high = System.Convert.ToUInt64(args[0]);
			} else {
				low = System.Convert.ToUInt64(args[0]);
				high = System.Convert.ToUInt64(args[1]);
			}
			
		} catch(Exception ex) {

			Console.WriteLine(ex.ToString());
			return;

		}
		
		string text = System.IO.File.ReadAllText("numbers");
		char[] delimiters = {'\n'};
		string[] numbers = text.Split(delimiters);

		for (ulong i = low; i < (ulong)numbers.Length ; i++) {
			numbers[i] = numbers[i].Replace("-","");
			// System.Console.WriteLine(numbers[i]);
		}
		System.Console.WriteLine("The sum of the lengths of each number from {0} to {1} is {2}",low ,high, tally);
	}
}