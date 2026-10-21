#!/usr/bin/env python3
"""Generate deterministic placeholder 'cat portrait' PNGs for the collection.

Each image is 256x256: a dark cat silhouette (round head, triangle ears,
amber eyes) on a colored background. Pure stdlib — no external deps.
"""
import math
import struct
import zlib

SIZE = 256

# name -> (background rgb, silhouette rgb)
CATS = {
    "onyx": ((28, 28, 34), (10, 10, 12)),
    "raven": ((44, 36, 60), (16, 12, 24)),
    "midnight": ((24, 34, 56), (8, 12, 22)),
    "eclipse": ((52, 30, 40), (18, 8, 14)),
    "noir": ((30, 42, 38), (10, 16, 14)),
    "luna": ((58, 48, 28), (20, 16, 8)),
    "salem": ((40, 40, 48), (12, 12, 18)),
}
EYES = (214, 168, 62)  # amber


def point_in_triangle(px, py, a, b, c):
    def sign(p1, p2, p3):
        return (p1[0] - p3[0]) * (p2[1] - p3[1]) - (p2[0] - p3[0]) * (p1[1] - p3[1])

    d1 = sign((px, py), a, b)
    d2 = sign((px, py), b, c)
    d3 = sign((px, py), c, a)
    has_neg = d1 < 0 or d2 < 0 or d3 < 0
    has_pos = d1 > 0 or d2 > 0 or d3 > 0
    return not (has_neg and has_pos)


def cat_pixels(bg, dark):
    cx, cy, r = SIZE / 2, 152, 78
    left_ear = ((60, 96), (84, 26), (128, 96))
    right_ear = ((196, 96), (172, 26), (128, 96))
    left_eye, right_eye, eye_r = (100, 142), (156, 142), 11
    rows = []
    for y in range(SIZE):
        row = []
        for x in range(SIZE):
            color = bg
            # head
            if math.hypot(x - cx, y - cy) <= r:
                color = dark
            # ears
            elif point_in_triangle(x, y, *left_ear) or point_in_triangle(x, y, *right_ear):
                color = dark
            # eyes
            if color is dark and math.hypot(x - left_eye[0], y - left_eye[1]) <= eye_r:
                color = EYES
            if color is dark and math.hypot(x - right_eye[0], y - right_eye[1]) <= eye_r:
                color = EYES
            row.append(color)
        rows.append(row)
    return rows


def write_png(path, rows):
    def chunk(tag, data):
        return (
            struct.pack(">I", len(data)) + tag + data
            + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
        )

    raw = b"".join(
        b"\x00" + bytes(v for px in row for v in px) for row in rows
    )
    png = (
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", struct.pack(">IIBBBBB", SIZE, SIZE, 8, 2, 0, 0, 0))
        + chunk(b"IDAT", zlib.compress(raw, 9))
        + chunk(b"IEND", b"")
    )
    with open(path, "wb") as fh:
        fh.write(png)


import os

os.makedirs("assets/cats", exist_ok=True)
for name, (bg, dark) in CATS.items():
    write_png(f"assets/cats/{name}.png", cat_pixels(bg, dark))
    print(f"wrote assets/cats/{name}.png")
