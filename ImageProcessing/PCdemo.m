function [row,col] = PCdemo(I,I2);
fi = fft2(double(I));
fr = fft2(double(I2));
fc = fi.*conj(fr);
fcn = fc./abs(fc);
peak_correlation_matrix = abs(ifft2(fcn));
[peak, idx] = max(peak_correlation_matrix(:));
[row,col] = ind2sub(size(peak_correlation_matrix),idx);
if row < size(peak_correlation_matrix,1)/2
    row = -(row -1);
else
    row = size(peak_correlation_matrix,1) - (row -1);
end;
if col < size(peak_correlation_matrix,2)/2;
    col = -(col-1);
else
    col = size(peak_correlation_matrix,2) - (col -1);
end
end

