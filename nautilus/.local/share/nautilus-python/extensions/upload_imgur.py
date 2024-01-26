from urllib.parse import urlparse, unquote
from gi.repository import Nautilus, GObject
import subprocess

from typing import List


class UploadImgur(GObject.GObject, Nautilus.MenuProvider):
    VALID_MIME_TYPES = "image/jpeg", "image/png", "image/webp", "image/gif"

    def _upload_to_imgur(self, _: Nautilus.MenuItem, file: Nautilus.FileInfo):
        file_path = unquote(urlparse(file.get_uri()).path)

        if subprocess.run(["which", "imgur.sh"]).returncode == 0:
            subprocess.Popen(["imgur-copy-link", file_path])
        else:
            print("imgur.sh is not available")
            return

    def get_file_items(self, files: List[Nautilus.FileInfo]) -> List[Nautilus.MenuItem]:
        if len(files) == 0 or len(files) > 1:
            return []

        file = files[0]
        if not file.get_mime_type() in self.VALID_MIME_TYPES:
            return []

        item_upload_imgur = Nautilus.MenuItem(
            name="Nautilus::upload_imgur",
            label="Upload to imgur",
            tip="Upload selected image to imgur",
        )

        item_upload_imgur.connect("activate", self._upload_to_imgur, file)

        return [item_upload_imgur]
