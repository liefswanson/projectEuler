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
	//[3,754,200,582,340]
	//[[0,3],[7,54],[2,0],[5,82],[3,40]]
	//three trillion, seven hundred and fifty-four billion, two hundred million, five hundred and eighty-two thousand, three hundred and forty

	//while temp > 0
	//append temp % 1000
	//temp / 1000

	//foreach item
	//append [current / 100,current % 100]

	//start doing substitutions

	public string english {get; private set;}
	public ulong value {get; private set;}

	public EnglishNumber(ulong value) {
		this.value = value;
		parseValue();
	}

	//note, both the list of ulongs and array of tuples of ulongs are intentionally backwards
	private void parseValue() {
		List<ulong> firstParse = new List<ulong>();
		ulong temp = value;
		while (temp > 0) {
			ulong current = temp % 1000;
			temp = temp / 1000;
			firstParse.Add(current);
		}
		
		Tuple<ulong,ulong>[] secondParse = new Tuple<ulong,ulong>[firstParse.Count];
		for (int i = 0; i < firstParse.Count; i++) {
			secondParse[i] = new Tuple<ulong,ulong>( firstParse[i]/100, firstParse[i]%100 );
		}
		Console.WriteLine(value.ToString());
		Console.WriteLine("[" + string.Join(", ",firstParse) + "]");

		Console.Write("[");
		for (int i = secondParse.Length-1; i >= 0; i--) {
			Console.Write(secondParse[i].ToString());
			if (i != 0) {
				Console.Write(", ");
			}
		}
		Console.Write("]\n");
		string english = makeString(secondParse);
		//Console.WriteLine(string.Join(",",secondParse));
	} 

	private String makeString(Tuple<ulong,ulong>[] digits) {
		string[] temp = new string[digits.Length];
		//build string here
	}
	
}

public class Program {

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
		
		string text = System.IO.File.ReadAllText("numbers");
		char[] delimiters = {'\n'};
		string[] numbers = text.Split(delimiters);

		EnglishNumber temp;
		for (ulong i = low; i < 100000000 ; i++) {
			temp = new EnglishNumber(i);
		}
		// System.Console.WriteLine("The sum of the lengths of each number from {0} to {1} is {2}",low ,high, tally);
	}
}