from urllib.parse import urlparse, unquote
import subprocess
from pathlib import Path
from gi.repository import Nautilus, GObject

from typing import List


class EncodeDecodeJxl(GObject.GObject, Nautilus.MenuProvider):
    def _encode_to_jxl(
        self,
        _: Nautilus.MenuItem,
        files: List[Nautilus.FileInfo],
    ) -> None:
        for file in files:
            file_path = unquote(urlparse(file.get_uri()).path)
            file_path_without_extension = Path(file_path).stem

            output_dir = unquote(urlparse(file.get_parent_uri()).path)
            output_name = f"{file_path_without_extension}.jxl"
            output_path = f"{output_dir}/{output_name}"

            subprocess.Popen(["cjxl", file_path, output_path])

    def _decode_to_png(
        self,
        _: Nautilus.MenuItem,
        files: List[Nautilus.FileInfo],
    ) -> None:
        for file in files:
            file_path = unquote(urlparse(file.get_uri()).path)
            file_path_without_extension = Path(file_path).stem

            output_dir = unquote(urlparse(file.get_parent_uri()).path)
            output_name = f"{file_path_without_extension}.png"
            output_path = f"{output_dir}/{output_name}"

            subprocess.Popen(
                [
                    "djxl",
                    file_path,
                    output_path,
                ]
            )

    def get_file_items(self, files: List[Nautilus.FileInfo]) -> List[Nautilus.MenuItem]:
        if len(files) == 0:
            return []

        item_encode = Nautilus.MenuItem(
            name="Nautilus::encode_to_jxl",
            label="Encode image(s) to jxl",
            tip="Encode selected image(s) to jxl",
        )

        item_decode = Nautilus.MenuItem(
            name="Nautilus::decode_jxl",
            label="Decode image(s) to png",
            tip="Decode selected image(s) to png",
        )

        item_encode.connect("activate", self._encode_to_jxl, files)
        item_decode.connect("activate", self._decode_to_png, files)

        items = []

        all_valid_mime = True
        for file in files:
            if file.get_mime_type() not in ["image/jpeg", "image/png"]:
                all_valid_mime = False
                break

        all_jxl = True
        for file in files:
            if file.get_mime_type() != "image/jxl":
                all_jxl = False
                break

        if all_valid_mime:
            items.append(item_encode)

        if all_jxl:
            items.append(item_decode)

        return items
