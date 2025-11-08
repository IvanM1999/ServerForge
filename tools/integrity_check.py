#!/usr/bin/env python3
import sys, json, hashlib, os, zipfile, tempfile, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "version.manifest"

def sha256_file(p):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()

def build_manifest():
    files = []
    for p in sorted([p for p in ROOT.rglob('*') if p.is_file()]):
        rel = p.relative_to(ROOT).as_posix()
        if rel.startswith('.git') or rel.startswith('installers') or rel=='version.manifest':
            continue
        files.append({'path': rel, 'sha256': sha256_file(p)})
    manifest = {'generated_at': None, 'files': files}
    MANIFEST.write_text(json.dumps(manifest, indent=2), encoding='utf-8')
    print('Manifest generated with', len(files), 'files')
    return manifest

def load_manifest():
    if not MANIFEST.exists():
        return None
    try:
        return json.loads(MANIFEST.read_text(encoding='utf-8'))
    except Exception:
        return None

def verify():
    m = load_manifest()
    if not m or not m.get('files'):
        print('No manifest or empty. Generating manifest.')
        build_manifest()
        return True
    ok = True
    for entry in m['files']:
        p = ROOT / entry['path']
        if not p.exists():
            print('MISSING:', entry['path']); ok=False; continue
        cur = sha256_file(p)
        if cur != entry['sha256']:
            print('CHANGED:', entry['path']); ok=False
    print('VERIFY', 'OK' if ok else 'FAILED')
    return ok

def restore_from_zip(paths):
    for zp in paths:
        zp = Path(zp)
        if not zp.exists():
            print('zip not found', zp); continue
        with zipfile.ZipFile(zp, 'r') as z:
            z.extractall(ROOT)
        print('Restored from', zp)

def full_restore():
    print('Full restore will download upstream not implemented in offline build.')
    return

if __name__=='__main__':
    import argparse
    p = argparse.ArgumentParser()
    p.add_argument('--verify', action='store_true')
    p.add_argument('--restore', nargs='+')
    p.add_argument('--full', action='store_true')
    args = p.parse_args()
    if args.verify:
        ok = verify()
        sys.exit(0 if ok else 3)
    if args.restore:
        restore_from_zip(args.restore); sys.exit(0)
    if args.full:
        full_restore(); sys.exit(0)
    p.print_help()
