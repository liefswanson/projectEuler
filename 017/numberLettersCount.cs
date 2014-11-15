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
	//three trillion, seven hundred and fifty-four billion, two hundred million, five hundred and eighty-two thousand, three hundred and forty

	//while temp > 0
	//append temp % 1000
	//temp / 1000

	//foreach item
	//append [current / 100,current % 100]

	//start doing substitutions

	public string english {get; private set;}
	public ulong value {get; private set;}

	static private string[] numbers = null;
	static private string[] quantifiers = null;

	public EnglishNumber(ulong value) {
		this.value = value;
		this.makeString(this.parseValue());
	}

	public static void initializeInternalsFromFiles(string numsFile, string quantsFile) {
		//TODO check for errors in the file read, it might be missing!
		//It may also have less than the number of lines it needs!
		char[] delimiters = {'\n'};

		string text = System.IO.File.ReadAllText(numsFile);
		EnglishNumber.numbers = text.Split(delimiters);

		//Console.Write(string.Join("\n",EnglishNumber.numbers));


		text = System.IO.File.ReadAllText(quantsFile);
		EnglishNumber.quantifiers = text.Split(delimiters);

		//Console.Write(string.Join("\n",EnglishNumber.quantifiers));

	}
	
	//note, the list of ushorts is intentionally backward
	private List<ushort> parseValue() {
		List<ushort> firstParse = new List<ushort>();
		ulong temp = value;
		while (temp > 0) {
			ushort current = (ushort)(temp % 1000);
			temp = temp / 1000;
			firstParse.Add(current);
		}
		
		//Console.WriteLine(value.ToString());
		//Console.WriteLine("[" + string.Join(", ",firstParse) + "]");

		return firstParse;
	} 

	private void makeString(List<ushort> parsed) {
		string[] temp = new string[parsed.Count];
		//build string here

		int j = 0;
		for (int i = parsed.Count-1; i >= 0; i--) {
			ushort hundreds = (ushort)(parsed[i] / 100);
			ushort remaining = (ushort)(parsed[i] % 100);

			switch (hundreds) {
			case 0:
				break;
			default:
				temp[j] += numbers[hundreds] + " Hundred ";
				break;
			}

			switch (remaining) {
			case 0:
				break;
			default:
				if (hundreds != 0) {
					temp[j] += "and ";
				}
					
				temp[j] += numbers[remaining];
				break;
			}

			if (hundreds != 0 || remaining != 0) {
				temp[j] += " " + quantifiers[i]; //quantifiers are organized as 1000^i
			}
			j++;
		}
		this.english = String.Join(" ",temp); 
	}

	public override string ToString() {
		return english;
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
		
		EnglishNumber.initializeInternalsFromFiles("numbers", "quantifiers");
		

		ulong tally = 0;
		EnglishNumber temp;
		for (ulong i = low; i <= high ; i++) {
			temp = new EnglishNumber(i);
			//Console.WriteLine(i);
			Console.WriteLine(temp);
			tally += (ulong)temp.english.Replace(" ", "").Replace("-", "").Length;
		}
		System.Console.WriteLine("The sum of the lengths of all numbers in english from {0} to {1} is {2}",low ,high, tally);
	}
}
