SRC_DIR=./src
TARGET=shortbread_test
BUILD_DIR=tmp

CXX=g++ -g

TARGET_SRC += $(wildcard $(SRC_DIR)/*.cpp)
TARGET_SRC += $(wildcard $(SRC_DIR)/**/*.cpp)
TARGET_SRC += $(wildcard $(SRC_DIR)/**/**/*.cpp)

TARGET_OBJ := $(notdir $(TARGET_SRC:.cpp=.o))
TARGET_OBJ := $(addprefix $(BUILD_DIR)/,$(TARGET_OBJ))

#extend the global setting
override CXXFLAGS+=-std=c++17 -Wall -Wextra -Wconversion -pedantic

SB_LIB_DIR=/usr/include/short-bread
RPATH=/usr/lib

override INC+=-I$(SRC_DIR)
override INC+=-I${SB_LIB_DIR}
override INC+=-I${SB_LIB_DIR}/dictionnary

override LDFLAGS+=-L${RPATH} -lshort-bread
override LDFLAGS+=-L${RPATH} -lcurl

.PHONY: all clean install uninstall deb

all: $(BUILD_DIR) $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) -c $(CXXFLAGS) $(INC) $^ -o $@ 

$(BUILD_DIR)/%.o: $(SRC_DIR)/**/%.cpp
	$(CXX) -c $(CXXFLAGS) $(INC) $^ -o $@ 

$(BUILD_DIR)/%.o: $(SRC_DIR)/**/**/%.cpp
	$(CXX) -c $(CXXFLAGS) $(INC) $^ -o $@ 

$(TARGET): $(BUILD_DIR) $(TARGET_OBJ)
	$(CXX) -o $@ ${TARGET_OBJ} $(LDFLAGS)

#remove build directory and other generated 
clean:
	$(RM) -rf $(TARGET) $(BUILD_DIR)
