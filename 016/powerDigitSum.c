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

#define _GNU_SOURCE
#include <gmp.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void sumOfDigits(mpz_t result, const mpz_t sequence);
unsigned long int ctouli (char c);


int main(int argc, char *argv[])
{
	if (argc < 3) {
		puts("expected usage:");
		puts("argo0: base (decimal number)");
		puts("arg1: exponent (decimal number)");
		exit(EXIT_FAILURE);
	}
	
	unsigned long int base;
	unsigned long int exp;
	mpz_t result;

	mpz_t sum;

	base = strtoul(argv[1],NULL,10);
	if (base == EINVAL) {
		puts("Please specify a number in base ten to be the base of the exponential");
		exit(EXIT_FAILURE);
	}
	
	exp = strtoul(argv[2],NULL,10);
	if (exp == EINVAL) {
		puts("Please specify a number in base ten to be the exponent of the exponential");
		exit(EXIT_FAILURE);
	}
	
	mpz_init(result);
	mpz_ui_pow_ui(result,base,exp);
	gmp_printf("The value of %lu^%lu is:\n\n%Zd\n\n",base,exp,result);

	sumOfDigits(sum, result);

	gmp_printf("The value of the sum of the digits of %lu^%lu is:\n\n%Zd",base,exp,sum);
	exit(EXIT_SUCCESS);
}

void sumOfDigits(mpz_t sum, const mpz_t sequence)
{
	mpz_init(sum);
	
	char* strSeq;
	gmp_asprintf(&strSeq,"%Zd", sequence);

	unsigned long int temp;
	unsigned long int i;
	for (i = 0; strSeq[i] != '\0'; i++) {
		temp = ctouli(strSeq[i]);
		mpz_add_ui(sum,sum,temp);
	}
}

unsigned long int ctouli (char c)
{
	return c -'0';
}
