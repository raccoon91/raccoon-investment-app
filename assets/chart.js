const white = '#e0e3e1';
const black = '#181c1c';
const green = '#81e6d9';
const red = '#ffb4ab';
const border = '#374040';

const chartOptions = {
  layout: {
    background: { color: black },
    textColor: white,
  },
  grid: {
    vertLines: { color: border },
    horzLines: { color: border },
  },
};

const candleChartOptions = {
  upColor: red,
  downColor: green,
  borderVisible: false,
  wickUpColor: red,
  wickDownColor: green,
};

window.addEventListener('flutterInAppWebViewPlatformReady', () => {
  const chart = LightweightCharts.createChart(document.getElementById('chart'), chartOptions);

  const candlestickSeries = chart.addCandlestickSeries(candleChartOptions);

  window.flutter_inappwebview.callHandler('chartData').then((result) => {
    console.log(JSON.stringify(result));

    candlestickSeries.setData(result);
    
    chart.timeScale().fitContent();
  });
});
