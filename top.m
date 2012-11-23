#! /usr/bin/octave -qf
## Copyright (C) 2012 reAsOn
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## top

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-11-22

%function [ ret ] = top ()
    clear;
    load ex7data2.mat;
    global data = X;
    global tryNum = 3;
    global step = 0.5;
    global visual = 2.5;
    global jamming = 0.1;
    global fishNum = 16;
    global maxIter = 10;
    global dimension = 2
    global defineRange = [0,7.5;0,7.5];
    af();
%endfunction
