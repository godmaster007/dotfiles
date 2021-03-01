#!/bin/bash


## Youtube-dl


YD1='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fty9pBk3fhkjN2BMF1_EDr'

#VM Folder using windows linux app
YD_Folder="/mnt/c/Users/nicho/Music/YD1"

# VM Folder using virtualbox
#YD_Folder="cd $HOME/Music/YD1"

$YD_Folder
  youtube-dl \
  --download-archive YD1_downloaded.txt \
  --no-post-overwrites \
  --audio-quality 320K \
  --add-metadata -ciwx \
  --audio-format "mp3" -o '%(title)s.%(ext)s' \
  --metadata-from-title '%(artist)s - %(title)s' \
  --embed-thumbnail \
  $YD1;
  cd ~


# YD1='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fty9pBk3fhkjN2BMF1_EDr'
# YD_Folder="cd $HOME/Music/YD1"

# YD () {
#   $YD_Folder
#   youtube-dl \
#   --download-archive YD1_downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format "mp3" -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   $YD1;
#   cd ~
# }


# PL1='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fdN6fcVne88peQ97qjGW-4'



# PL2='https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-co5UkkjbMf8R_KWnM_KFBz'
# PL1D="cd $HOME/Music/Youtube/TEST1"
# PL2D="cd $HOME/Music/Youtube/TEST2"

# YD1 () {
#   $PL1D
#   youtube-dl \
#   --download-archive PL1D_downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format "mp3" -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   $PL1;
#   cd ~
# }



# # $1 = LINK (Either song or playlist link from youtube)
# # TEST1 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-fdN6fcVne88peQ97qjGW-4
# # TEST2 = https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-co5UkkjbMf8R_KWnM_KFBz
# # $2 = DESTINATION (Full path, if VM create dir with host first)
# # TEST1 DIR = cd /mnt/c/Users/nicho/Youtube/TEST1
# # TEST2 DIR = cd /mnt/c/Users/nicho/Youtube/TEST2
# # $3 = FORMAT (Either mp3 OR wav *if unspecified default is mp3*)
# #
# # YD () {
# #   "$2"
# #   youtube-dl \
# #   --download-archive downloaded.txt \
# #   --no-post-overwrites \
# #   --audio-quality 320K \
# #   --add-metadata -ciwx \
# #   --audio-format "$3" -o '%(title)s.%(ext)s' \
# #   --metadata-from-title '%(artist)s - %(title)s' \
# #   if [ "$3" = 'mp3' ]; then
# #     --embed-thumbnail \
# #   fi
# #   "$1"
# #   cd ~
# # }

# # OLD CONFIGURATIONS
# # Troubleshoot: "youtube-dl -F --verbose https://www.youtube.com/playlist?list=PLgJ5ZeA-kk-cSmEL0MmKfx02_Y7lKxDyH"
# YD () {
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format mp3 -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   "$1"
# }
# # Download playlist as WAV files
# YDVM () {
#   cd ~/Downloads/YoutubeDL
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format mp3 -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   "$1"
# }
# # Download playlist as MP3 files into shared directory
# YD_MS () {
#   cd /mnt/c/Users/nicho/Downloads/YoutubeDL/mp3
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format mp3 -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   --embed-thumbnail \
#   "$1"
#   cd ~
# }
# # Download playlist as WAV files into shared directory
# YD_WS () {
#   cd /mnt/c/Users/nicho/Downloads/YoutubeDL/wav
#   youtube-dl \
#   --download-archive downloaded.txt \
#   --no-post-overwrites \
#   --audio-quality 320K \
#   --add-metadata -ciwx \
#   --audio-format wav -o '%(title)s.%(ext)s' \
#   --metadata-from-title '%(artist)s - %(title)s' \
#   "$1"
#   cd ~
# }