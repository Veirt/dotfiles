from urllib.parse import urlparse, unquote
from gi.repository import Nautilus, GObject
import subprocess

from typing import List


class CopyContentOfFile(GObject.GObject, Nautilus.MenuProvider):
    def _copy_content_of_file(self, _: Nautilus.MenuItem, file: Nautilus.FileInfo):
        file_path = unquote(urlparse(file.get_uri()).path)

        if subprocess.run(["which", "xclip"]).returncode == 0:
            process = subprocess.Popen(
                ["xclip", "-sel", "clip", "-target", file.get_mime_type()],
                stdin=subprocess.PIPE,
            )
        elif subprocess.run(["which", "wl-copy"]).returncode == 0:
            process = subprocess.Popen(["wl-copy"], stdin=subprocess.PIPE)
        else:
            print("No xclip or wl-copy available.")
            return

        if process.stdin:
            with open(file_path, "rb") as file:
                process.stdin.write(file.read())
                process.stdin.close()

    def get_file_items(self, files: List[Nautilus.FileInfo]) -> List[Nautilus.MenuItem]:
        if len(files) == 0 or len(files) > 1:
            return []

        file = files[0]
        if file.get_mime_type() == "inode/directory":
            return []

        item_copy_content = Nautilus.MenuItem(
            name="Nautilus::copy_content",
            label="Copy content of file",
            tip="Copy the content of the file, instead of copying the path",
        )

        item_copy_content.connect("activate", self._copy_content_of_file, file)

        return [item_copy_content]
