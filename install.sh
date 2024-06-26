#!/usr/bin/env sh
#
# MIT License
#
# Copyright (c) 2024  Hilault
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#

echo "Installing maintainance-shutdown tool"

# shellcheck disable=SC2046
if [ $(whoami) != "root" ]; then
    echo "* ERROR: Must be root or use sudo."
    exit 1
fi

echo "* Installing..."
install -o root -g root -m 644 units/maintainance-shutdown.timer /etc/systemd/system/ || exit 1
install -o root -g root -m 644 units/maintainance-shutdown.service /etc/systemd/system/ || exit 1
install -o root -g root -m 755 bin/maintainance-shutdown /usr/local/bin/ || exit 1
install -o root -g root -m 755 -d /var/run/maintainance-shutdown || exit 1

echo "* Starting..."
systemctl enable maintainance-shutdown.timer || exit 1
systemctl start maintainance-shutdown.timer || exit 1

echo "* Done!"
exit 0
