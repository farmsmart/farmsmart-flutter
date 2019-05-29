import re
import json

class VersionInfo:
    def __init__(self, maj: int, min: int, patch: int, build=None):
        self.maj = maj
        self.min = min
        self.patch = patch
        self.build = build

    @classmethod
    def from_version_name(cls, version_string: str) -> 'VersionInfo':

        version_match = re.search("(\d+)\.(\d+)\.(\d+)", version_string)

        if version_match is None:
            raise Exception('Incorrect version detected, it must be in the form: \d+\.\d+\.\d+')

        maj = int(version_match.group(1))
        min = int(version_match.group(2))
        patch = int(version_match.group(3))

        return cls(maj, min, patch)

    @classmethod
    def from_version_code(cls, version_code: int) -> 'VersionInfo':

        version = str(version_code)

        if len(version) < 4:
            raise Exception('Invalid version code, it must be at least 4 digits')

        build = version[len(version) - 3:]

        start = 0 if len(version) == 4 else len(version) - 5
        patch = version[start:len(version) - 3]

        if len(version) > 5:
            start = 0 if len(version) == 6 else len(version) - 7
            min = version[start:len(version) - 5]
        else:
            min = 0

        if len(version) > 7:
            maj = version
            maj = maj[0:len(maj) - 7]
        else:
            maj = 0

        return cls(int(maj), int(min), int(patch), int(build))

    def get_version_name(self):
        return f'{self.maj}.{self.min}.{self.patch}-{self.build}'

    def get_version_code(self):
        version_code = '{:0=2d}{:0=2d}{:0=2d}{:0=3d}'.format(self.maj, self.min, self.patch, self.build)
        return int(version_code)

    def as_json(self):
        version = {
            "version_name": self.get_version_name(),
            "version_code": self.get_version_code()
        }
        return json.dumps(version)

    def version_is_equal(version, next_version):
        return(
            version.maj == next_version.maj and
            version.min == next_version.min and
            version.patch == next_version.patch
        )

    @staticmethod
    def next_version_is_valid(current_version, next_version):
        if next_version.maj > current_version.maj:
            return True
        elif next_version.min > current_version.min:
            return True
        elif next_version.patch > current_version.patch:
            return True
        elif VersionInfo.version_is_equal(next_version, current_version):
            return True
        return False

    @staticmethod
    def get_next_build(current_version, next_version):
        if VersionInfo.next_version_is_valid(current_version, next_version):
            if VersionInfo.version_is_equal(current_version, next_version):
                return current_version.build + 1
            return 1
