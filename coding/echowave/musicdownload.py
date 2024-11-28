import os
import re
from yt_dlp import YoutubeDL

def sanitize_filename(filename):
    """
    Sanitize the output filename by removing illegal characters.
    """
    return re.sub(r'[<>:"/\\|?*]', '', filename)

def download_audio_from_youtube(url, filename):
    """
    Download the audio from a YouTube video using yt-dlp.
    """
    output_path = 'ytmusic'
    if not os.path.exists(output_path):
        os.makedirs(output_path)

    # Download best audio using yt-dlp
    ydl_opts = {
        'verbose': True,
        'format': 'bestaudio',
        'outtmpl': os.path.join(output_path, f"{filename}.%(ext)s"),
        }
    with YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(url, download=True)
        downloaded_file = ydl.prepare_filename(info_dict)

    print(f"Audio downloaded as: {downloaded_file}")

def run_youtube_downloader():
    """
    Continuously ask for search queries and download the first YouTube result as MP3.
    """
    try:
        print("welcome to fliploader!!!")
        search_query = input("enter a yt link (or q to quit): ").strip()
        if search_query.lower() == 'q':
            print("exiting the downloader.")
            
            # Check if the input is a valid YouTube link
        if 'youtube.com/watch?v=' in search_query or 'youtu.be/' in search_query:
            first_video_url = search_query
            print(f"using provided youtube link: {first_video_url}")

                # Ask for the filename for the downloaded audio
            filename = input("enter a name for the output file (without extension): ").strip()
            filename = sanitize_filename(filename)  # Sanitize the filename
            download_audio_from_youtube(first_video_url, filename)
        else:
            print("invalid youtube link")

    except Exception as e:
        input(f"error:\n\n'{e}'\n\npress enter to close...")

# Example usage
if __name__ == "__main__":
    run_youtube_downloader()
