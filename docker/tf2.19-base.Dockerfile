FROM starlabunist/pathfinder:base


#######################
# Install Python 3.11 #
#######################

RUN apt update && \
    apt install -y software-properties-common && \
    apt install -y python3.11 && \
    rm /usr/bin/python3 && \
    ln -s /usr/bin/python3.11 /usr/bin/python3


#################
# Install Bazel #
#################

RUN cd $HOME && \
    wget https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64 && \
    mkdir $HOME/bin && \
    mv $HOME/bazelisk-linux-amd64 $HOME/bin/bazelisk-linux-amd64 && \
    chmod +x $HOME/bin/bazelisk-linux-amd64 && \
    ln -s $HOME/bin/bazelisk-linux-amd64 $HOME/bin/bazel
ENV PATH=$HOME/bin:$PATH


####################
# Clone TensorFlow #
####################

ENV TENSORFLOW=$HOME/tensorflow
RUN git clone --branch v2.19.0 https://github.com/tensorflow/tensorflow.git $TENSORFLOW --depth 1

COPY ./docker/tensorflow-2.18.0-clang19-compat.patch $TENSORFLOW/tensorflow-2.18.0-clang19-compat.patch
COPY ./docker/tf2.19-WORKSPACE.patch $TENSORFLOW/tf2.19-WORKSPACE.patch

WORKDIR $TENSORFLOW

RUN git apply tensorflow-2.18.0-clang19-compat.patch &&\
    rm tensorflow-2.18.0-clang19-compat.patch

RUN git apply tf2.19-WORKSPACE.patch && \
    rm tf2.19-WORKSPACE.patch

RUN python3 -m pip install -U pip numpy wheel packaging requests opt_einsum patchelf && \
    python3 -m pip install -U keras_preprocessing --no-deps
