--
--Copyright (C)2019 Popov Artem Igorevich
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU Affero General Public License as
--published by the Free Software Foundation, either version 3 of the
--License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Affero General Public License for more details.
--
--You should have received a copy of the GNU Affero General Public License
--	along with this program.  If not, see <http://www.gnu.org/licenses/>.

function letter (n)
		if n == 0 then return 'A'
	elseif n == 1 then return 'B'
	elseif n == 2 then return 'C'
	elseif n == 3 then return 'D'
	elseif n == 4 then return 'E'
	elseif n == 5 then return 'F'
	else return nil	end
end

function is_number(a)
	if a == '0' or a == '1' or a == '2' or a == '3' or a == '4' or a == '5' or a == '6' or a == '7' or a == '8' or a == '9' then return true else return false end
end

function swap(n,m)--swap for less code
	swp=tablev[n]
	tablev[n]=tablev[m]
	tablev[m]=swp;
end

function swap_up(n)
	if n > 10 then swap(n, n-10) end
end

function swap_down(n)
	if n < 91 then swap(n, n+10) end
end

function swap_left(n)
	if (n-1)%10 > 0 then swap(n, n-1) end
end

function swap_right(n)
	if (n-1)%10 < 9 then swap(n, n+1) end
end

function AddDrop(n)
	if indrop == 0 then
		indrop = 1
		dropqueue[1] = n
	else
		for i=1,indrop do
			if dropqueue[i] == n then return end
		end
		indrop = indrop+1
		dropqueue[indrop] = n
	end
end

function Drop()
	if indrop ~= 0 then
		for i=1,indrop do tablev[dropqueue[i]]=' ' end
		haschange = true
	end
	indrop = 0
	MyPrintExport(tablev)
end

function Gravity()
	for i=0,8 do
		for j=10,100 - 10*i do
			if tablev[j] == ' ' then swap_up(j) hasEtop = true end
		end
	end
	MyPrintExport(tablev)
end

function Shuffle()
	attempt = false
	for i=0,98 do swap(100-i,math.random(1,100-i)) end
	if FastCheck() == true or CheckForReady() == false then attempt = true end
	indrop = 0
	while attempt == true do
		attempt = false
		for i=0,98 do swap(100-i,math.random(1,100-i)) end
		if FastCheck() == true or CheckForReady() == false then attempt = true end
		indrop = 0
	end
	MyPrintExport(tablev)
end

function FillEmptyTop()
	for i=1,10 do
		if tablev[i] == ' ' then tablev[i] = letter(math.random(0,5)) end
	end
	MyPrintExport(tablev)
end

function FastCheck()
	ret_val = false
	for i=1,100 do
		if  tablev[i] == tablev[i+1]
		and tablev[i] == tablev[i+2]
		and (i-1)%10 < 8 and tablev[i] ~= ' ' then
			AddDrop(i)
			AddDrop(i+1)
			AddDrop(i+2)
			ret_val = true
		end
		if  tablev[i]== tablev[i+10]
		and tablev[i] == tablev[i+20]
		and i < 81 and tablev[i] ~= ' ' then
			AddDrop(i)
			AddDrop(i+10)
			AddDrop(i+20)
			ret_val = true
		end
	end
	return ret_val
end

function CheckForReady()
	for i=1,100 do
		--x check
		if tablev[i] == tablev[i+1]  and i > 10       and (i-1)%10 < 8 and tablev[i] == tablev[i-8]  then return true end
		if tablev[i] == tablev[i+1]  and (i-1)%10 < 7 and                  tablev[i] == tablev[i+3]  then return true end
		if tablev[i] == tablev[i+1]  and i < 91       and (i-1)%10 < 8 and tablev[i] == tablev[i+12] then return true end
		if tablev[i] == tablev[i+1]  and i > 10       and (i-1)%10 > 1 and tablev[i] == tablev[i-11] then return true end
		if tablev[i] == tablev[i+1]  and (i-1)%10 > 2 and                  tablev[i] == tablev[i-2]  then return true end
		if tablev[i] == tablev[i+1]  and i < 91       and (i-1)%10 > 1 and tablev[i] == tablev[i+9]  then return true end
		if tablev[i] == tablev[i-9]  and i > 10       and (i-1)%10 < 8 and tablev[i] == tablev[i+2]  then return true end
		if tablev[i] == tablev[i+11] and i < 91       and (i-1)%10 < 8 and tablev[i] == tablev[i+2]  then return true end
		--y check
		if tablev[i] == tablev[i+10] and i < 81       and (i-1)%10 > 0 and tablev[i] == tablev[i+19] then return true end
		if tablev[i] == tablev[i+10] and i < 71       and                  tablev[i] == tablev[i+30] then return true end
		if tablev[i] == tablev[i+10] and i < 81       and (i-1)%10 < 9 and tablev[i] == tablev[i+21] then return true end
		if tablev[i] == tablev[i+10] and i > 10       and (i-1)%10 > 0 and tablev[i] == tablev[i-11] then return true end
		if tablev[i] == tablev[i+10] and i > 20       and                  tablev[i] == tablev[i-20] then return true end
		if tablev[i] == tablev[i+10] and i > 10       and (i-1)%10 < 9 and tablev[i] == tablev[i-9]  then return true end
		if tablev[i] == tablev[i+9]  and i < 81       and (i-1)%10 > 0 and tablev[i] == tablev[i+20] then return true end
		if tablev[i] == tablev[i+11] and i < 81       and (i-1)%10 < 9 and tablev[i] == tablev[i+20] then return true end
	end
	return false
end

function init()
	if inited == false then math.randomseed(os.time()) inited = true end
	for i=1,100 do tablev[i] = letter(math.random(0,5)) end
	ready = false
	while ready == false do
		if FastCheck() then for i=1,100 do tablev[i] = letter(math.random(0,5)) end indrop = 0
		elseif CheckForReady() then MyPrintExport(tablev) return
		else for i=1,100 do tablev[i] = letter(math.random(0,5)) end
		end
	end
end

function input(a)
	inplen=inplen+1
	inputline[inplen]=a
end
	function tick(a)
	if inited == true and haschange == true then Gravity() haschange = false return end
	if inplen == 3
	and inputline[1] == 'm'
	and inputline[2] == 'i'
	and inputline[3] == 'x'
	and inited == true then
		inplen = 0 Shuffle() return
	end
	if inplen == 4 then
		inplen = 0
		if  inputline[1] == 'i'
		and inputline[2] == 'n'
		and inputline[3] == 'i'
		and inputline[4] == 't' then
			init()
			return
		end
		if inited == true and inputline[1] == 'm' then
			if is_number( inputline[2] ) and is_number( inputline[3] ) then
				shift = 1 + tonumber( inputline[2] ) + tonumber(inputline[3])* 10
			end
			if  inputline[4] == 'l' then swap_left(shift)	if not FastCheck() then swap_left(shift)	end end
			if  inputline[4] == 'u' then swap_up(shift)		if not FastCheck() then swap_up(shift)		end end
			if  inputline[4] == 'r' then swap_right(shift)	if not FastCheck() then swap_right(shift)	end end
			if  inputline[4] == 'd' then swap_down(shift)	if not FastCheck() then swap_down(shift)	end end
			MyPrintExport(tablev)
			return
		end
		MyPrintExport(tablev)
	end
	if inited == true and FastCheck() then Drop() hasEtop = true haschange = true return end
	if inited == true and hasEtop == true then FillEmptyTop() hasEtop = false haschange = true return end
end

--function MyPrintExport()	end
hasEtop = true
inited = false
haschange = false
tablev = {}
dropqueue = {}
indrop = 0
inputline = {}
inplen = 0
