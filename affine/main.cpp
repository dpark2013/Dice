//
//  main.cpp
//  affine
//
//  Created by Dan Park on 3/19/19.
//  Copyright © 2019 Dan Park. All rights reserved.
//

#include <vector>
#include <string>
#include <iostream>

struct CoordinateXY {
    float x;
    float y;
    float w;
};

CoordinateXY computeXYPrime(const std::vector<float> &H, const int x, const int y) {
    CoordinateXY xyPrime;
    xyPrime.x = H[0] * x + H[1] * y + H[2] * 1;
    xyPrime.y = H[3] * x + H[4] * y + H[5] * 1;
    xyPrime.w = H[6] * x + H[7] * y + H[8] * 1;

    return xyPrime;
}

CoordinateXY computeXYReverse(const std::vector<float> &H, const int x, const int y) {
    CoordinateXY xyPrime;
    xyPrime.x = H[0] * x + H[1] * y + H[2] * 1;
    xyPrime.y = H[3] * x + H[4] * y + H[5] * 1;
    xyPrime.w = H[6] * x + H[7] * y + H[8] * 1;
    
    return xyPrime;
}


int main(int argc, const char * argv[]) {

    // Some random values given for H
    std::vector<float> H {1, 2, 3, 4, 5, 6, 7, 8, 9};

    const int width = 100;
    const int height = 100;
    const float threshold = 0.3;

    // a very small image containining width x height pixels
    // flatten gray image as a 1d array
    // assuming it was loaded with intensity values from 0 to 255.
    std::vector<int> inputImage(width * height);
    
    // init output image with zero intensity values.
    std::vector<int> outputImage(width * height, 0);
    
    
    for (int row = 0; row < height; row++) {
        for (int col = 0; col < width; col++) {
            CoordinateXY xyPrime = computeXYPrime(H, row, col);

            // if x' or y' is on the borderline...
            // threshold is 30% of the borderline.
            if (xyPrime.x - int(xyPrime.x) > threshold &&
                xyPrime.y - int(xyPrime.y) > threshold) {

                float intensity = inputImage[row * width + col];
                
                xyPrime.x /= xyPrime.w;
                xyPrime.y /= xyPrime.w;
                outputImage[int(xyPrime.x) * width + int(xyPrime.y)] = intensity;
            } else {
                
                CoordinateXY xy = computeXYReverse(H, xyPrime.x, xyPrime.y);
                float intensity = inputImage[xy.x * width + xy.y];
                outputImage[int(xyPrime.x) * width + int(xyPrime.y)] = intensity;
            }
        }
    }

    return 0;
}
