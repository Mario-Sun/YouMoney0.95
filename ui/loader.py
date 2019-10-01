import wx
from io import StringIO
from io import BytesIO


def load_bitmap(ipath):
    return wx.Bitmap(wx.Image(BytesIO(open(ipath, 'rb').read())))


def load_image(ipath):
    return wx.Image(StringIO(open(ipath, 'rb').read()))