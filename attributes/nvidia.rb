default['zoo_workstation']['nvidia']['install'] = false
default['zoo_workstation']['nvidia']['packages'] = [
  # NVIDIA DRIVER - REQUIRES NVIDIA REPO
  'nvidia-driver',
  'kernel-devel',
  'dkms-nvidia',
  'nvidia-driver-devel',
  'nvidia-texture-tools-devel',
  'nvidia-driver-cuda',
  'cuda-devel',
  'cuda-cli-tools',
  'cuda-docs',
  'cuda-samples',
  'cuda-cublas-devel',
  'cuda-cudart-devel',
  'cuda-cufft-devel',
  'cuda-cupti-devel',
  'cuda-curand-devel',
  'cuda-cusolver-devel',
  'cuda-cusparse-devel',
  'cuda-npp-devel',
  'cuda-nvgraph-devel',
  'cuda-nvml-devel',
  'cuda-nvrtc-devel',
  'nvidia-xconfig'
]
