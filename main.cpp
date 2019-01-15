//
//Copyright(C)2019 Popov Artem Igorevich
//
//This program is free software : you can redistribute it and / or modify
//it under the terms of the GNU Affero General Public License as
//published by the Free Software Foundation, either version 3 of the
//License, or (at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
//GNU Affero General Public License for more details.
//
//You should have received a copy of the GNU Affero General Public License
//	along with this program.If not, see <http://www.gnu.org/licenses/>.

#define _CRT_SECURE_NO_WARNINGS
#include <chrono>
#include <conio.h>
#include <Windows.h>
#include "LUA.hpp"
#include "include\LuaBridge\LuaBridge.h"

void MyPrintExport(luabridge::LuaRef table);
using namespace luabridge;

int main()
{
	lua_State* L = luaL_newstate();
	std::string filename = "game.lua";
	luaL_dofile(L, filename.c_str());
	luaL_openlibs(L);
	getGlobalNamespace(L).addFunction("MyPrintExport", MyPrintExport);
	lua_pcall(L, 0, 0, 0);
	LuaRef usrinput = getGlobal(L, "input");
	LuaRef tick = getGlobal(L, "tick");
	char lt = 0;
	auto start = std::chrono::steady_clock::now();
	do{
		auto end = std::chrono::steady_clock::now();
		if (std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() > 500)//2fps
		{
			tick();
			start = end;
		}
		if(_kbhit())
		{
			lt = _getch();
			if (lt != '\n' && lt != '\0')
			{
				_putch(lt);
				usrinput(lt);
			}
		}
	}while (lt != 'q');
	return 0;
}


void MyPrintExport(luabridge::LuaRef table)
{
	Sleep(500);
	system("@cls||clear");
	putchar(' ');
	putchar(' ');
	for (int8_t x = 0; x < 10; x++)
	{
		putchar(' ');
		putchar('0' + x);
	}
	putchar('\n');
	putchar(' ');
	putchar(' ');
	for (int8_t x = 0; x < 10; x++)
	{
		putchar(' ');
		putchar('-');
	}
	putchar('\n');
	for (int8_t y = 0; y < 10; y++)
	{
		putchar('0' + y);
		putchar(' ');
		putchar('|');
		for (int8_t x = 0; x < 10; x++)
		{
			char print_val = table[1 + x + 10 * y];
			putchar(print_val);
			putchar(' ');
		}
		putchar('\n');
	}
}
