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




//======================
//eg: of parse technique
//======================

//3754254582340
//[3,754,200,582,340]
//three trillion seven hundred and fifty-four billion two hundred million five hundred and eighty-two thousand three hundred and forty

//while temp > 0
//append temp % 1000
//temp / 1000

//foreach item
//append [current / 100,current % 100]

//start doing substitutions
using System;
using System.Collections.Generic;

namespace EulerSeventeen {

	public class EnglishNumber {
	
		public string english {get; private set;}
		public ulong value {get; private set;}

		public EnglishNumber(ulong value) {
			this.value = value;
		    var temp = this.parseValue();
			this.makeString(temp);
		}

		//note, the list of ushorts is intentionally backward
		private List<ushort> parseValue() {
			List<ushort> parse = new List<ushort>();
			ulong temp = value;
			while (temp > 0) {
				ushort current = (ushort)(temp % 1000);
				temp = temp / 1000;
				parse.Add(current);

			}
		
			//Console.WriteLine(value.ToString());
			//Console.WriteLine("[" + string.Join(", ",firstParse) + "]");

			return parse;
		} 

		private void makeString(List<ushort> intoThousands) {
			string[] unjoinedResult = new string[intoThousands.Count];

			int i = intoThousands.Count-1;
			int j = 0;

			for (; i >= 0; i--, j++) {

				ushort hundreds = (ushort)(intoThousands[i] / 100);
				ushort remaining = (ushort)(intoThousands[i] % 100);

				switch (hundreds) {
				case 0:
					break;
				default:
					unjoinedResult[j] += numbers[hundreds] + " Hundred ";
					break;
				}

				switch (remaining) {
				case 0:
					break;
				default:
					if (hundreds != 0) {
						unjoinedResult[j] += "and ";
					}
					
					unjoinedResult[j] += numbers[remaining];
					break;
				}

				if (hundreds != 0 || remaining != 0) {
					unjoinedResult[j] += " " + quantifiers[i]; //quantifiers are organized as 1000^i
				}
			}
			this.english = String.Join(" ",unjoinedResult); 
		}

		public override string ToString() {
			return english;
		}


		static readonly public string[] numbers =
		{
			"zero",
			"one",
			"two",
			"three",
			"four",
			"five",
			"six",
			"seven",
			"eight",
			"nine",
			"ten",
			"eleven",
			"twelve",
			"thirteen",
			"fourteen",
			"fifteen",
			"sixteen",
			"seventeen",
			"eighteen",
			"nineteen",
			"twenty",
			"twenty-one",
			"twenty-two",
			"twenty-three",
			"twenty-four",
			"twenty-five",
			"twenty-six",
			"twenty-seven",
			"twenty-eight",
			"twenty-nine",
			"thirty",
			"thirty-one",
			"thirty-two",
			"thirty-three",
			"thirty-four",
			"thirty-five",
			"thirty-six",
			"thirty-seven",
			"thirty-eight",
			"thirty-nine",
			"forty",
			"forty-one",
			"forty-two",
			"forty-three",
			"forty-four",
			"forty-five",
			"forty-six",
			"forty-seven",
			"forty-eight",
			"forty-nine",
			"fifty",
			"fifty-one",
			"fifty-two",
			"fifty-three",
			"fifty-four",
			"fifty-five",
			"fifty-six",
			"fifty-seven",
			"fifty-eight",
			"fifty-nine",
			"sixty",
			"sixty-one",
			"sixty-two",
			"sixty-three",
			"sixty-four",
			"sixty-five",
			"sixty-six",
			"sixty-seven",
			"sixty-eight",
			"sixty-nine",
			"seventy",
			"seventy-one",
			"seventy-two",
			"seventy-three",
			"seventy-four",
			"seventy-five",
			"seventy-six",
			"seventy-seven",
			"seventy-eight",
			"seventy-nine",
			"eighty",
			"eighty-one",
			"eighty-two",
			"eighty-three",
			"eighty-four",
			"eighty-five",
			"eighty-six",
			"eighty-seven",
			"eighty-eight",
			"eighty-nine",
			"ninety",
			"ninety-one",
			"ninety-two",
			"ninety-three",
			"ninety-four",
			"ninety-five",
			"ninety-six",
			"ninety-seven",
			"ninety-eight",
			"ninety-nine"
		};

		static readonly public string[] quantifiers =
		{
			"",
			"Thousand",
			"Million",
			"Billion",
			"Trillion",
			"Quadrillion",
			"Quintillion"
		};
	}
}
