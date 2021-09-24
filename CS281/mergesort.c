#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Partially following example code for conceptual analysis from: https://www.geeksforgeeks.org/merge-sort/
//Time functionality learned from https://www.youtube.com/watch?v=I-vw0aIZ4FI&ab_channel=iTzAdam5X
//Random seeding learned from https://www.youtube.com/watch?v=oXEDMNXzuo4&t=40s&ab_channel=LearningLad

//Prototypes
void mergeSort(int *array, int length);
void mergeSortR(int *array, int *auxArray, int start, int end);
void merge(int *array, int *auxArray, int start, int mid, int end);
int* createRandomArray(int size); 
void printArray(int *inputArray, int size);

/*
    Main creates an array of random ints of an input size, 
    Uses the mergeSort algorithm to sort it, 
    Then prints out the final array and the time elapsed during the sort. 
    @param int argc contains number of args passed in to the program 
    @param char **argv contains char array of what each input parameter is 
    @returns 0 or 1 depending on execution completion 
*/
int main(int argc, char **argv) {
    
    //runs only if we input the desired array size
    if (argc == 2) {
        
        //convert argv to int for use 
        int size = atoi(argv[1]);
    
        //Create a Random Array of size 
        int* randArray = createRandomArray(size);
        
        //Print initial array 
        printArray(randArray, size);
        
        //Tell user size of array we are sorting 
        printf("\n"); 
        printf("Sorting array of size: %d \n", size);
        
        //Sort the array using mergeSort
        mergeSort(randArray, size); 
        
        //Print final state of array after sort 
        printArray(randArray, size);
        printf("\n");
        
        //Free the main array in memory before exiting the program. 
        free(randArray);
        
    } else {
        
        //Complain if there are not enough or too many args passed in
        printf("Input too many or too little arguments!");
        
    }
    
    //Keep track of time elapsed since program start, and print it
    int ticks = clock();
    printf("Time elapsed: %f ms \n", ((float)ticks / CLOCKS_PER_SEC) * 1000);
    
    return 0;
}

/*
    mergeSort takes in an array and its length to sort. 
    This function is only called once and has a recursive helper
    function to do all the dirty work. mergeSort's main job is to 
    allocate the memory for the temp array and make the first 
    call to begin the recursion
    @param int *array the array to be sorted 
    @param int length the length of the array to be sorted 
*/
void mergeSort(int *array, int length) {
    
    //Only mergeSort if our array size is greater than 1. 
    if(length == 1) {
        return;
    }
    
    //Determine array sizes
    int halfSize = length / 2;
    
    //Allocate memory for temp array 
    int *auxArray = (int*)malloc(halfSize * sizeof(int));

    //Call recusive mergesort function 
    mergeSortR(array, auxArray, 0, length);

    //Free the memory allocated to the temp array 
    free(auxArray);
}

void mergeSortR(int *array, int *auxArray, int start, int end) {
    
    //Calculate our midpoint 
    int mid = (start + end) / 2;
    
    //Recurse on Left side first if there is more than 1 element to look at 
    if((mid - start) > 1) {
        mergeSortR(array, auxArray, start, mid);
    }
    //Recurse on Right side next if there is more than 1 element to look at
    if((end - mid) > 1) {
        mergeSortR(array, auxArray, mid, end);
    }
    //Merge our Left and Rights together after they have been sorted 
    merge(array, auxArray, start, mid, end);
}

//For merge 
//Copy left to aux array
//Compare to first element of right 
//Place compared into main array 
/*
    Merge is a helper function that takes a main array, 
    an auxillary array, and the start, mid, and end positions
    of the main array to help merge the sorted pieces of the 
    main array. 
    @param int *array The main array that the sort is happening on 
    @param int *auxArray The half sized array to help with merging left and right
    @param int start The start position of the main array (not always 0)
    @param int mid The middle position of the main array 
    @param int end The end position of the main array 
*/
void merge(int *array, int *auxArray, int start, int mid, int end) {
    
    //Calculate the length of the left half 
    int leftL = mid - start;
    
    //Fill the temp array with the left side of our main array 
    for(int i = 0; i < leftL; i++) {
        auxArray[i] = array[i + start]; 
    }
    
    //Counter variables 
    int l = 0; 
    int r = mid;

    //For every position in the main array... 
    for(int i = start; i < end; i++) {
        //if right is exhausted, pick l 
        if(r >= end) {
            //printf("rearranging...\n");
            array[i] = auxArray[l];
            l++; 
        //left is exhausted, pick r 
        } else if (l >= leftL) {
            array[i] = array[r];
            r++; 
        //if left is greater pick r
        } else if(auxArray[l] > array[r]){
            array[i] = array[r];
            r++;
        //otherwise pick left
        } else {
            array[i] = auxArray[l];
            l++;
        }
    }
}

/*
    createRandomArray is a helper function to the main function 
    that takes care of creating and filling the Random Array 
    that we will do the mergeSort on. 
    @param int size The size of the array that we want to create and fill
    @returns int* The randomArray that was created
*/
int* createRandomArray(int size) {
    
    //Allocate the memory for the random array
    int *randArray = (int*)malloc(size * sizeof(int)); 
    
    //Seed the random number generator 
    srand(time(NULL));
    
    //Fill the array with random numbers between 0 and the numeric size of the array
    for(int i = 0; i < size; i++) {
        randArray[i] = rand() % size; 
    }
    return randArray; 
}

/*
    printArray takes an array and prints it to the screen. 
    Used to tidy up the code in main. 
    @param int *inputArray The array to be printed 
    @param int size The size of the array to be printed
*/
void printArray(int *inputArray, int size) {
    
    //Loop through the array, printing all the elements,
    //ommiting the ',' from the last element
    for (int i = 0; i < size; i++) {
        if(i < size - 1) {
            printf("%d,", inputArray[i]);
        } else {
            printf("%d", inputArray[i]);
        }
    }
}
