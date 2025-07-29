//-----------------------------------------------------------------------------
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
//  Script Name: vn_inc_gui
//  Description: Simple GUI support functions - not system specific.
//------------------------------------------------------------------------------

string EncodeGUIInt(string sPrefix, int nValue)
{
	return sPrefix + IntToString(nValue);
}

int DecodeGUIInt(string sPrefix, string sCode)
{
	int nCodeLength = GetStringLength(sCode);
	int nPrefixLength = GetStringLength(sPrefix);
	string sValue = GetSubString(sCode, nPrefixLength, nCodeLength - nPrefixLength);
	
	return StringToInt(sValue);
}