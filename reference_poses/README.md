# Reference camera poses for the query images of the San Francisco Landmarks dataset

This package includes reference camera poses for the query images of the San Francisco Landmarks dataset [1,2]. The reference poses computed and evaluated in our CVPR17 paper [3] are provided in two formats: ``reference_poses_467.txt`` (plain text) and ``reference_poses_467.mat`` (matlab). 

We additionally include the modified version of the reference poses: ``reference_poses_467_ext.txt`` (plain text) and ``reference_poses_467_ext.mat`` (matlab). The CVPR17 version geo-registers the camera poses obtained from SfM using 7 DoF similarity transform but this modified version uses 5 DoF (direction of gravity vector is extracted from the PCI meta data) which resulted more accurate rotation estimation.

## Data format description

* ``reference_poses.txt`` (plain text)

    Each line in this file file contains query name, rotation in quaternion, and camera position in the UTM coordinates, e.g. 

    ```
    0 <query name> <1x4 quaternion> <1x3 camera position>
    ```

    So the rotation matrix ``` R ``` of the reference pose is calculated by standard quaternion to rotation transformation and
    the translation vector ``` t ``` is calculated as ``` t = -R * c ``` where ``` c ``` is the camera position in the text file. 

* ``reference_poses.mat`` (matlab binary)
    
    This file contains struct array ``poses`` which has fields ``name`` and ``P``. For example, ``poses(1).name`` returns the name of query image and ``poses(1).P`` returnes a 3x4 projection matrix of the query in the UTM coordinates. 


* ``reference_poses_467_ext.txt`` and ``reference_poses_467_ext.mat`` follow the same format as in the CVPR17 version.

### References

[1] D. Chen, G. Baatz, K. Koeser, S. Tsai, R. Vedantham, T. Pylvanainen, K. Roimela, X. Chen, J. Bach, M. Pollefeys, B. Girod, and R. Grzeszczuk: City-scale landmark identification on mobile devices". CVPR 2011. 

[2] San Francisco Landmark Dataset. [https://purl.stanford.edu/vn158kj2087](https://purl.stanford.edu/vn158kj2087)

[3] T, Sattler, A. Torii, J. Sivic, M. Pollefeys, H. Taira, M. Okutomi, T. Pajdla: Are Large-Scale 3D Models Really Necessary for Accurate Visual Localization? CVPR 2017.

