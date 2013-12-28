function [ output_args ] = outputtofile( galaxies )
%OUTPUTTOFILE Summary of this function goes here
%   Outputs data to file 

    disp('Outputting data to file')

    galaxies_file = fopen('galaxies.txt','w');
    fprintf(galaxies_file,'%6s, %6s, %6s\n','brightness', 'y', 'x');
    [l,w] = size(galaxies);
    % loop through array and output
    for c=1:l
        fprintf( galaxies_file, '%6d, %6d, %6d\n', galaxies(c),  galaxies(c+l),  galaxies( c+(2*l) ) );
    end
    % close output file
    fclose(galaxies_file);
    
    disp('Data outputted to galaxies.txt')

end