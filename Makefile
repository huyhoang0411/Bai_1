.PHONY: objs mkstatic all clean



PROJECT_NAME := hello

CUR_DIR := .

INC_DIR := $(CUR_DIR)/inc
LIB_DIR := $(CUR_DIR)/lib
OBJ_DIR := $(CUR_DIR)/obj
BIN_DIR := $(CUR_DIR)/bin
SRC_DIR := $(CUR_DIR)/src
LIB_STATIC := $(LIB_DIR)/static
LIB_SHARED := $(LIB_DIR)/shared

INC_FLAG := -I $(INC_DIR)

CC := gcc

objs:
	$(CC) -c -o $(OBJ_DIR)/main.o main.c $(INC_FLAG)
	$(CC) -c -o $(OBJ_DIR)/hello_world.o $(SRC_DIR)/hello_world.c $(INC_FLAG)
	$(CC) -c -o $(OBJ_DIR)/hello_Hoang.o $(SRC_DIR)/hello_Hoang.c $(INC_FLAG)

mkstatic:
	ar rcs $(LIB_STATIC)/libhello.a $(OBJ_DIR)/hello_Hoang.o $(OBJ_DIR)/hello_world.o

mkshared:
	$(CC) -shared $(OBJ_DIR)/hello_Hoang.o $(OBJ_DIR)/hello_world.o -o $(LIB_SHARED)/libhello.so

linkshared:
	$(CC)  $(OBJ_DIR)/main.o -L$(LIB_SHARED) -lhello -o $(BIN_DIR)/$(PROJECT_NAME)
	LD_LIBRARY_PATH=$(LIB_SHARED) $(BIN_DIR)/$(PROJECT_NAME)
	

all:
	$(CC) $(OBJ_DIR)/main.o -L$(LIB_STATIC) -lhello -o $(BIN_DIR)/$(PROJECT_NAME)

clean:
	rm -rf $(OBJ_DIR)/*
	rm -rf $(LIB_STATIC)/*
	rm -rf $(LIB_SHARED)/*
	rm -rf $(BIN_DIR)/*