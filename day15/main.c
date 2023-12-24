/* Example in C */
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int LEFT = 2;
int RIGHT = 4;
int UP = 8;
int DOWN = 16;

struct Hist {
  uint8_t dir_mask;
};

struct Op {
  int idx;
  int dir;
};

void add_history(struct Hist * history, int idx, int dir) {
  //uint8_t mask = 0 | (dir+1);
  uint8_t mask = dir;
  printf("?????:::::::::\n");
  printf("?? adding ::::\n");
  printf("idx %i dir %d mask %i \n", idx, dir, mask);
  printf("mask ... %i\n", history[idx].dir_mask); // bit fns agaisnt this
  printf("mask & ... %i\n", history[idx].dir_mask | mask); // bit fns agaisnt this
  printf("?????:::::::::\n");
  printf("?????:::::::::\n");
  history[idx].dir_mask = history[idx].dir_mask | mask;
}

void add(struct Op * opstack, int i, int idx, int dir) {
  opstack[i].idx = idx;
  opstack[i].dir = dir;
}

int did_visit(struct Hist * history, int idx, int dir) {
  uint8_t mask = dir;
  printf("::::::::::::::\n");
  printf(":: checking ::\n");
  printf("idx %i dir %d mask %i \n", idx, dir, mask);
  printf("mask ... %i\n", history[idx].dir_mask); // bit fns agaisnt this
  printf("mask & ... %i\n", history[idx].dir_mask & mask); // bit fns agaisnt this
  printf("::::::::::::::\n");
  printf("::::::::::::::\n");
  return history[idx].dir_mask & mask; // bit fns agaisnt this
}


int resolve(struct Hist * history, struct Op * opstack, int * ii, char * map, char * traversed, int lineLen) {
  int i = *ii;
  int idx = opstack[i].idx;
  int dir = opstack[i].dir;
  opstack[i].idx = 0;
  opstack[i].dir = 0;
  int netPushPop = -1;


  printf("---- resolving ii %i - loc %i, dir %i\n", i, idx, dir);

  char value;
  if(idx < 0 || idx > strlen(map)) {
    printf(" ?? out of bounds (%i)\n", idx);
    return netPushPop;
  } else {
    value = map[idx];
    printf(" %c \n", value);
  }

  if(value != '\n') {
    char marker = '.';
    if(dir == RIGHT) {
      marker = '>';
    } else if (dir == LEFT) {
      marker = '<';
    } else if (dir == UP) {
      marker = '^';
    } else if (dir == DOWN) {
      marker = 'V';
    }
    if(value == '.') {
      traversed[idx] = marker;
    } else {
      traversed[idx] = value;
    }
    //traversed[idx]++;// = marker;
  }

  if(did_visit(history, idx, dir)) {
    return netPushPop;
  } else {
    add_history(history, idx, dir);
  }

  if (dir == RIGHT) {
    if(map[idx] == '.' || map[idx] == '-') {
      netPushPop++;
      add(opstack, i, idx+1, RIGHT);
    } else if (map[idx] == '\\') {
      netPushPop++;
      add(opstack, i, idx+lineLen, DOWN);
    } else if (map[idx] == '/') {
      netPushPop++;
      add(opstack, i, idx-lineLen, UP);
    } else if (map[idx] == '|') {
      netPushPop++;
      add(opstack, i, idx-lineLen, UP);
      netPushPop++;
      add(opstack, i + 1, idx+lineLen, DOWN);
    }
  } else if (dir == LEFT) {
    if(map[idx] == '.' || map[idx] == '-') {
      netPushPop++;
      add(opstack, i, idx-1, LEFT);
    } else if (map[idx] == '\\') {
      netPushPop++;
      add(opstack, i, idx-lineLen, UP);
    } else if (map[idx] == '/') {
      netPushPop++;
      add(opstack, i, idx+lineLen, DOWN);
    } else if (map[idx] == '|') {
      netPushPop++;
      add(opstack, i, idx-lineLen, UP);
      netPushPop++;
      add(opstack, i + 1, idx+lineLen, DOWN);
    }
  } else if (dir == UP) {
    if(map[idx] == '.' || map[idx] == '|') {
      add(opstack, i, idx-lineLen, UP);
      netPushPop++;
    } else if (map[idx] == '\\') {
      netPushPop++;
      add(opstack, i, idx-1, LEFT);
    } else if (map[idx] == '/') {
      netPushPop++;
      add(opstack, i, idx+1, RIGHT);
    } else if (map[idx] == '-') {
      netPushPop++;
      add(opstack, i, idx + 1, RIGHT);
      netPushPop++;
      add(opstack, i + 1, idx - 1, LEFT);
    }
  } else if (dir == DOWN) {
    if(map[idx] == '.' || map[idx] == '|') {
      add(opstack, i, idx+lineLen, DOWN);
      netPushPop++;
    } else if (map[idx] == '\\') {
      netPushPop++;
      add(opstack, i, idx+1, RIGHT);
    } else if (map[idx] == '/') {
      netPushPop++;
      add(opstack, i, idx-1, LEFT);
    } else if (map[idx] == '-') {
      netPushPop++;
      add(opstack, i, idx + 1, RIGHT);
      netPushPop++;
      add(opstack, i + 1, idx - 1, LEFT);
    }
  } else {
      printf(" unhandled\n");
  }
  printf("\n---- %i \n", netPushPop);
  return netPushPop;
}

void doStuff(char * map, char * traversed, int lineLen) {
    struct Op * opstack = 0;
    opstack = malloc(100000);
    struct Hist * history = 0;
    history = malloc(100000);
    int opStackIdx = 0;

    add(opstack, opStackIdx, 0, RIGHT);

    int count = 0;
    while ( opStackIdx >= 0) {
      count++;

//    int idx = opstack[opStackIdx].idx;
//    int dir = opstack[opStackIdx].dir;
//      printf("in ii - %i\n", opStackIdx);
      opStackIdx += resolve(history, opstack, &opStackIdx, map, traversed, lineLen);
      printf("out ii - %i\n", opStackIdx);

    }
    printf("total count - %i\n", count);
    printf("hell yea - %lu\n", strlen(map) );
    printf("%s\n", map);
    printf("hell yea - %lu\n", strlen(traversed) );
    printf("%s\n", traversed);
    printf("xxxxxxx\n");
    printf("%i\n", opstack[0].idx);
    printf("%i\n", opstack[0].dir);

    int i = 0;
    int total = 0;
    while(i < strlen(traversed) ){
      int match = (traversed[i] == '.') || (traversed[i] == '\n');
//        printf("uh.. (%c) %i \n", traversed[i], match);
      if(traversed[i] == '.' || traversed[i] == '\n') {
      } else {
        total++;
      }
      i++;
    }
    // too low 740
    printf("TOTAL TRAVERSED: %i\b", total);
}

int main(void) {
    char string[] = "Wiki means fast?";
    int i;
    for (i = 0; i < sizeof(string) - 1; ++i) {
        /* transform characters in place, one by one */ 
        string[i] = tolower(string[i]);
    }
    puts(string);                       /* "wiki means fast?" */


    char * buffer = 0;
    char * traversed = 0;
    long length;
    //FILE * f = fopen ("example", "rb");
    FILE * f = fopen ("input", "rb");

    if (f)
    {
      fseek (f, 0, SEEK_END);
      length = ftell (f);
      fseek (f, 0, SEEK_SET);
      buffer = malloc(length);
      traversed = malloc(length);
      if (buffer)
      {
        fread (buffer, 1, length, f);
      }
      fclose (f);
    }
    int lineLen = 0;
    while(buffer[lineLen] != '\n') {
      lineLen++;
    }
    lineLen++;
    printf( ":::::::: - %d\n", lineLen );

    char arr[112][112] = {};
    if (buffer)
    {
      int idx = 0;
        printf( "%lu\n", strlen(buffer) );
      while( idx < strlen(buffer) ) {
        traversed[idx] = '.';
        if((idx % (lineLen)) == 0) {
          printf( "LINE - %d\n", idx / (lineLen+1) );
        }
        if(buffer[idx] == '\n') {
          printf( " - %d", idx );
          traversed[idx] = '\n';
        }
        printf( "%c", buffer[idx] ); //printing each token
        //printf( "%s\n", token ); //printing each token
        //token = strtok(NULL, " ");
        idx++;
      }
    }

    printf( ":::::::: - %d\n", lineLen );
    printf( "%s", buffer ); //printing each token
    printf( ":::::::: - %d\n", lineLen );
    printf( "%s", traversed ); //printing each token
    printf( ":::::::: - %d\n", lineLen );

    doStuff(buffer, traversed, lineLen);

    uint8_t mask_a = RIGHT + 1;
    uint8_t mask_b = UP + 1;
    printf("\nmask check %i\n", mask_a & mask_b );
    return 0;
}
