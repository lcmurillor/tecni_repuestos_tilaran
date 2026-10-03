"""Restore the credited catalog images when an asset is missing (Python 3)."""
import json
import time
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CREDITS = ROOT / 'assets/products/credits.json'


def main():
    for item in json.loads(CREDITS.read_text(encoding='utf-8')):
        target = ROOT / item['asset']
        if target.exists():
            print(f'Already present: {target.name}')
            continue
        for attempt in range(3):
            try:
                request = urllib.request.Request(
                    item['download'],
                    headers={'User-Agent': 'TecniDemo/1.0 (portfolio image attribution)'},
                )
                with urllib.request.urlopen(request, timeout=60) as response:
                    image = response.read()
                    if not response.headers.get('Content-Type', '').startswith('image/') or not image.startswith(b'\xff\xd8'):
                        raise ValueError(f'Expected JPEG: {target.name}')
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(image)
                print(f'Downloaded: {target.name}')
                time.sleep(2)
                break
            except urllib.error.HTTPError as error:
                if error.code != 429 or attempt == 2:
                    raise
                time.sleep(30)


if __name__ == '__main__':
    main()
