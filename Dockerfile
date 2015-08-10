FROM continuumio/miniconda

RUN apt-get update
RUN apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler unzip
RUN apt-get install --no-install-recommends libboost-all-dev
RUN conda install ipython-notebook numpy scipy pil protobuf nose scikit-image dateutil boost cython h5py pandas python-gflags
CPLUS_INCLUDE_PATH=/opt/conda/include/python2.7

RUN \
  # glog
  wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz &
  tar zxvf glog-0.3.3.tar.gz &
  cd glog-0.3.3 &
  ./configure &
  make && make install &
  # gflags
  wget https://github.com/schuhschuh/gflags/archive/master.zip &
  unzip master.zip &
  cd gflags-master &
  mkdir build && cd build &
  export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1 &
  make && make install & 
  # lmdb &
  git clone https://github.com/LMDB/lmdb &
  cd lmdb/libraries/liblmdb &
  make && make install
