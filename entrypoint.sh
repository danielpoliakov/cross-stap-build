#!/bin/sh

help() {
  echo "Usage: "
  echo "run -a <architecture> -k <kernel_path> <stp_file>"
  echo
  echo "Supported architectures:"
  echo " - x86_64"
  echo " - i386"
  echo " - arm"
  echo " - aarch64"
  echo " - mips"
}

while getopts "a:k:h" o; do
case "$o" in
  a)
    arch=$OPTARG
    ;;
  k)
    kernel=$OPTARG
    ;;
  h)
    help
    exit 0
    ;;
  *)
    help
    exit 1
    ;;
esac
done

shift $((OPTIND-1))

src=$*

if [ "${arch}" = "" -o "${kernel}" = "" -o "${src}" = "" ]; then
  help
  exit 1
fi

if [ ! -d "/csb/stapbuild-${arch}" ]; then
  echo "Unsupported architecture: ${arch}"
  echo
  help
  exit 1
fi

echo "Selected architecture: ${arch}"
echo "Kernel path: ${kernel}"
echo "Source .stp file: ${src}"

cp ${src} "/"

src_basename=$(basename ${src})
out_dir=$(dirname ${src})
out_file=${src_basename%.*}.ko
abs_kernel_path=$(readlink -f ${kernel})

/csb/stapbuild-${arch}/build.sh ${src_basename} ${abs_kernel_path} || exit 1

cp ${out_file} ${out_dir}
