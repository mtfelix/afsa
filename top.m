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

function [ ret ] = top ()

conf_file_name = input("Input configuration file:", "s");
[conf_file, MSG] = fopen(conf_file_name, 'r');
if conf_file == -1
    printf("%s\n", MSG);
else
    data_file = fscanf(conf_file, "LOAD_DATA_FILE=%s\n");
    data_name = fscanf(conf_file, "DATA_NAME=%s\n");
    printf("%s\n", data_file);
    printf("%s\n", data_name);
    loaded = load(data_file, data_name);
    global data = loaded.X;
    global tryNum = fscanf(conf_file, "TRY_NUMBER=%d\n");
    global step = fscanf(conf_file, "STEP=%f\n");
    global visual = fscanf(conf_file, "VISUAL=%f\n");
    global jamming = fscanf(conf_file, "JAMMING=%f\n");
    global fishNum = fscanf(conf_file, "FISH_NUM=%d\n");
    global maxIter = fscanf(conf_file, "MAX_ITER=%d\n");
    global dimension = fscanf(conf_file, "DIMENSION=%d\n");
    
    global defineRange = [];
    for i = 1:dimension
        lower = fscanf(conf_file, "LOWER_BOUND=%f\n");
        upper = fscanf(conf_file, "UPPER_BOUND=%f\n");
        defineRange = [defineRange;[lower, upper]];
    endfor
    fclose(conf_file);
    af();
endif

endfunction
