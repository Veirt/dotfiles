from urllib.parse import urlparse, unquote
import subprocess
from pathlib import Path
from gi.repository import Nautilus, GObject

from typing import List


class UpscaleImageWithESRGAN(GObject.GObject, Nautilus.MenuProvider):
    VALID_MIME_TYPES = "image/jpeg", "image/png", "image/webp"

    def _upscale_image_with_esrgan(
        self,
        _: Nautilus.MenuItem,
        files: List[Nautilus.FileInfo],
    ) -> None:
        for file in files:
            file_path = unquote(urlparse(file.get_uri()).path)
            file_path_without_extension = Path(file_path).stem

            output_dir = unquote(urlparse(file.get_parent_uri()).path)
            output_name = f"{file_path_without_extension}_esrgan.png"
            output_path = f"{output_dir}/{output_name}"

            subprocess.Popen(
                ["realesrgan-ncnn-vulkan", "-i", file_path, "-o", output_path]
            )

    def _upscale_image_with_waifu2x(
        self,
        _: Nautilus.MenuItem,
        files: List[Nautilus.FileInfo],
    ) -> None:
        for file in files:
            file_path = unquote(urlparse(file.get_uri()).path)
            file_path_without_extension = Path(file_path).stem

            output_dir = unquote(urlparse(file.get_parent_uri()).path)
            output_name = f"{file_path_without_extension}_waifu2x.png"
            output_path = f"{output_dir}/{output_name}"

            subprocess.Popen(
                [
                    "waifu2x-ncnn-vulkan",
                    "-n",
                    "3",
                    "-s",
                    "2",
                    "-i",
                    file_path,
                    "-o",
                    output_path,
                ]
            )

    def get_file_items(self, files: List[Nautilus.FileInfo]) -> List[Nautilus.MenuItem]:
        if len(files) == 0:
            return []

        for file in files:
            if not file.get_mime_type() in self.VALID_MIME_TYPES:
                return []

        item_esrgan = Nautilus.MenuItem(
            name="Nautilus::upscale_with_esrgan",
            label="Upscale image with ESRGAN",
            tip="Use realesrgan-ncnn-vulkan to upscale by 2x",
        )

        item_waifu2x = Nautilus.MenuItem(
            name="Nautilus::upscale_with_waifu2x",
            label="Upscale image with waifu2x",
            tip="Use waifu2x-ncnn-vulkan to upscale by 3x",
        )

        item_esrgan.connect("activate", self._upscale_image_with_esrgan, files)
        item_waifu2x.connect("activate", self._upscale_image_with_waifu2x, files)

        return [
            item_esrgan,
            item_waifu2x,
        ]
