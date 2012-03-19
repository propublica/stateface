OBJ = font-for-us.o src/shape.o
CXX = g++
CC  = g++
CPPFLAGS = -g $(shell pkg-config --cflags cairo) \
  $(shell gdal-config --cflags)
LDFLAGS = -g
LDLIBS =  -lstdc++ -lm $(shell pkg-config --libs cairo) \
  $(shell gdal-config --libs)

all: font-for-us

font-for-us: $(OBJ)

font-for-us.o: src/shape.o
src/shape.o: src/shape.cpp src/shape.h

clean:
	rm ./font-for-us
	rm -rf *.o
	rm -rf src/*.o

state-plane: all
	ruby ./state-planes.rb
	mv *.eps ../eps/state-plane/

albers: all
	./font-for-us -s 5 -p 'EPSG:3083' -n Postal ./us-states/ne_10m_admin_1_states_provinces_lakes_shp.shp
	./font-for-us -s 1 -p 'EPSG:3083' -n Postal ./us-states/unioned.shp
	mv *.eps ../eps/albers/

.PHONY: all state-plane albers
