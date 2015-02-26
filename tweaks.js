function rgb2hex(rgb) {
  rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);

  function hex(x) {
    return ("0" + parseInt(x).toString(16)).slice(-2);
  }

  return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}

$(function() {
  window.color_manifest = {
    "#3c995b": {
      "primary": "#56D72B",
      "secondary": "#D4F1C9"
    },
    "#536ca6": {
      "primary": "#1D9BF6",
      "secondary": "#C8EBFC"
    },
    "#d47f1e": {
      "primary": "#BF57DA",
      "secondary": "#ECD5F2"
    },
    "#9643a5": {
      "primary": "#FD8308",
      "secondary": "#FEE5C0"
    }
  }

  window.renderCheckInterval = setInterval(function() {
    if ($('.chip').length > 0) {
      clearInterval(window.renderCheckInterval);

      $('.chip').each(function(index, chip) {
        var ch = $(chip);
        var dl = ch.find('dl');
        var dt = ch.find('dt');
        var dd = ch.find('dd');

        var o_color = rgb2hex(dl.css('background-color'));
        var colors = (window.color_manifest[o_color] || window.color_manifest["default"]);
        colors = window.color_manifest[Object.keys(window.color_manifest)[Math.floor(Math.random() * Object.keys(window.color_manifest).length)]];
        var p_color = colors["primary"];
        var s_color = colors["secondary"];

        dt.text(dt.text().replace(/ /g, ''));
        dt.text(dt.text().replace('–', ' – '));

        dl.css('height', ($(dl).height() + 1) + 'px');
        dl.css('width', ($(dl).width() - 3) + 'px');
        dl.css('margin-top', '1px');
        dt.css('background-color', s_color);
        dl.css('background-color', s_color);
        dl.css('color', p_color);

        ch.css('border-left', '3px solid ' + p_color);
      });
    }
  }, 100);
})