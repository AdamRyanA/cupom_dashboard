import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

showTimeRangePicker({
  required BuildContext context,
  TimeOfDay? start,
  TimeOfDay? end,
  TimeRange? disabledTime,
  Color? disabledColor,
  PaintingStyle paintingStyle = PaintingStyle.stroke,
  void Function(TimeOfDay)? onStartChange,
  void Function(TimeOfDay)? onEndChange,
  Duration interval = const Duration(minutes: 5),
  String fromText = "De",
  String toText = "Até as",
  bool use24HourFormat = true,
  double padding = 36,
  double strokeWidth = 12,
  Color? strokeColor,
  double handlerRadius = 12,
  Color? handlerColor,
  Color? selectedColor,
  Color? backgroundColor,
  Widget? backgroundWidget,
  int ticks = 0,
  double ticksOffset = 0,
  double? ticksLength,
  double ticksWidth = 1,
  Color ticksColor = Colors.white,
  bool snap = false,
  List<ClockLabel>? labels,
  double labelOffset = 20,
  bool rotateLabels = true,
  bool autoAdjustLabels = true,
  TextStyle? labelStyle,
  TextStyle? timeTextStyle,
  TextStyle? activeTimeTextStyle,
  bool hideTimes = false,
  bool hideButtons = false,
  double clockRotation = 0,
  Duration? maxDuration,
  Duration minDuration = const Duration(minutes: 30),
  TransitionBuilder? builder,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  bool barrierDismissible = true,
  Color? timeColor,
  ButtonStyle? buttonStyle,

}) async {
  assert(debugCheckHasMaterialLocalizations(context));
  final Widget dialog = Dialog(
      elevation: 12,
      child: TimeRangePicker(
        start: start,
        end: end,
        disabledTime: disabledTime,
        paintingStyle: paintingStyle,
        onStartChange: onStartChange,
        onEndChange: onEndChange,
        fromText: fromText,
        toText: toText,
        interval: interval,
        padding: padding,
        strokeWidth: strokeWidth,
        handlerRadius: handlerRadius,
        strokeColor: strokeColor,
        handlerColor: handlerColor,
        selectedColor: selectedColor,
        backgroundColor: backgroundColor,
        disabledColor: disabledColor,
        backgroundWidget: backgroundWidget,
        ticks: ticks,
        ticksLength: ticksLength,
        ticksWidth: ticksWidth,
        ticksOffset: ticksOffset,
        ticksColor: ticksColor,
        snap: snap,
        labels: labels,
        labelOffset: labelOffset,
        rotateLabels: rotateLabels,
        autoAdjustLabels: autoAdjustLabels,
        labelStyle: labelStyle,
        timeTextStyle: timeTextStyle,
        activeTimeTextStyle: activeTimeTextStyle,
        hideTimes: hideTimes,
        use24HourFormat: use24HourFormat,
        clockRotation: clockRotation,
        maxDuration: maxDuration,
        minDuration: minDuration,
        timeColor: timeColor,
        buttonStyle: buttonStyle,
      ));
  return await showDialog<TimeRange>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => builder == null ? dialog : builder(context, dialog),
    routeSettings: routeSettings,
  );
}

class TimeRangePicker extends StatefulWidget {
  final TimeOfDay? start;
  final TimeOfDay? end;
  final TimeRange? disabledTime;
  final void Function(TimeOfDay)? onStartChange;
  final void Function(TimeOfDay)? onEndChange;
  final Duration interval;
  final String toText;
  final String fromText;
  final double padding;
  final double strokeWidth;
  final double handlerRadius;
  final Color? strokeColor;
  final Color? handlerColor;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? disabledColor;
  final PaintingStyle paintingStyle;
  final Widget? backgroundWidget;
  final int ticks;
  final double ticksOffset;
  final double ticksLength;
  final double ticksWidth;
  final Color ticksColor;
  final bool snap;
  final List<ClockLabel>? labels;
  final double labelOffset;
  final bool rotateLabels;
  final bool autoAdjustLabels;
  final TextStyle? labelStyle;
  final TextStyle? timeTextStyle;
  final TextStyle? activeTimeTextStyle;
  final bool hideTimes;
  final bool hideButtons;
  final bool use24HourFormat;
  final double clockRotation;
  final Duration? maxDuration;
  final Duration minDuration;
  final Color? timeColor; 
  final ButtonStyle? buttonStyle;

  TimeRangePicker({
    Key? key,
    this.start,
    this.end,
    this.disabledTime,
    this.onStartChange,
    this.onEndChange,
    this.fromText = "De",
    this.toText = "Até as",
    this.interval = const Duration(minutes: 5),
    this.padding = 36,
    this.strokeWidth = 12,
    this.handlerRadius = 12,
    this.strokeColor,
    this.handlerColor,
    this.selectedColor,
    this.backgroundColor,
    this.disabledColor,
    this.paintingStyle = PaintingStyle.stroke,
    this.backgroundWidget,
    this.ticks = 0,
    ticksLength,
    this.ticksWidth = 1,
    this.ticksOffset = 0,
    this.ticksColor = Colors.white,
    this.snap = false,
    this.labels,
    this.labelOffset = 20,
    this.rotateLabels = true,
    this.autoAdjustLabels = true,
    this.labelStyle,
    this.timeTextStyle,
    this.activeTimeTextStyle,
    this.clockRotation = 0,
    this.maxDuration,
    this.minDuration = const Duration(minutes: 30),
    this.use24HourFormat = true,
    this.hideTimes = false,
    this.hideButtons = false,
    this.timeColor,
    this.buttonStyle,
  })  : ticksLength = ticksLength == null ? strokeWidth : 12,
        assert(interval.inSeconds <= minDuration.inSeconds,
        "o intervalo deve ser menor ou igual à duração mínima - ajuste qualquer um deles"),
        assert(
        interval.inSeconds < 24 * 60 * 60, "interval must be smaller 24h"),
        assert(minDuration.inSeconds < 24 * 60 * 60,
        " a duração mínima deve ser menor 24h"),
        super(key: key);
  @override
  TimeRangePickerState createState() => TimeRangePickerState();
}

class TimeRangePickerState extends State<TimeRangePicker> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  ActiveTime? _activeTime;
  double _startAngle = 0;
  double _endAngle = 0;
  double? _disabledStartAngle;
  double? _disabledEndAngle;
  final GlobalKey _circleKey = GlobalKey();
  final GlobalKey _wrapperKey = GlobalKey();
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  double _radius = 50;
  double _offsetRad = 0;

  @override
  void initState() {
    _offsetRad = (widget.clockRotation * pi / 180);
    WidgetsBinding.instance.addObserver(this);
    setAngles();
    WidgetsBinding.instance.addPostFrameCallback((_) => setRadius());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) => setRadius());
  }

  setRadius() {
    RenderBox? wrapper =
    _wrapperKey.currentContext?.findRenderObject() as RenderBox?;
    if (wrapper != null) {
      setState(() {
        _radius = min(wrapper.size.width, wrapper.size.height) / 2 - (widget.padding);
      });
    }
  }

  void setAngles() {
    setState(() {
      var startTime = widget.start ?? TimeOfDay.now();
      var endTime = widget.end ??
          startTime.replacing(
              hour: startTime.hour < 21
                  ? startTime.hour + 3
                  : startTime.hour - 21);
      _startTime = _roundMinutes(startTime.hour * 60 + startTime.minute * 1.0);
      _startAngle = timeToAngle(_startTime, _offsetRad);
      _endTime = _roundMinutes(endTime.hour * 60 + endTime.minute * 1.0);

      if (widget.maxDuration != null) {
        var startDate =
        DateTime(2020, 1, 1, _startTime.hour, _startTime.minute);
        var endDate = DateTime(2020, 1, 1, _endTime.hour, _endTime.minute);
        var duration = endDate.difference(startDate);
        if (duration.inMinutes > widget.maxDuration!.inMinutes) {
          var maxDate = startDate.add(widget.maxDuration!);
          _endTime = TimeOfDay(hour: maxDate.hour, minute: maxDate.minute);
        }
      }
      _endAngle = timeToAngle(_endTime, _offsetRad);
      if (widget.disabledTime != null) {
        _disabledStartAngle =
            timeToAngle(widget.disabledTime!.startTime, _offsetRad);
        _disabledEndAngle =
            timeToAngle(widget.disabledTime!.endTime, _offsetRad);
      }
    });
  }

  TimeOfDay _angleToTime(double angle) {
    angle = normalizeAngle(angle - pi / 2);
    double min = 24 * 60 * (angle) / (pi * 2);
    return _roundMinutes(min);
  }

  TimeOfDay _roundMinutes(double min) {
    int roundedMin = ((min / widget.interval.inMinutes).round() * widget.interval.inMinutes);
    int hours = (roundedMin / 60).floor();
    int minutes = (roundedMin % 60).round();
    return TimeOfDay(hour: hours, minute: minutes);
  }

  bool _panStart(PointerDownEvent ev) {
    bool isHandler = false;
    var globalPoint = ev.position;
    var snap = widget.handlerRadius * 2.5;
    RenderBox circle =
    _circleKey.currentContext!.findRenderObject() as RenderBox;
    CustomPaint customPaint = _circleKey.currentWidget as CustomPaint;
    ClockPainter clockPainter = customPaint.painter as ClockPainter;

    if (clockPainter.startHandlerPosition == null) {
      setState(() {
        _activeTime = ActiveTime.start;
      });
      return false;
    }

    Offset globalStartOffset =
    circle.localToGlobal(clockPainter.startHandlerPosition);
    if (globalPoint.dx < globalStartOffset.dx + snap &&
        globalPoint.dx > globalStartOffset.dx - snap &&
        globalPoint.dy < globalStartOffset.dy + snap &&
        globalPoint.dy > globalStartOffset.dy - snap) {
      setState(() {
        _activeTime = ActiveTime.start;
      });
      isHandler = true;
    }

    if (clockPainter.endHandlerPosition == null) {
      setState(() {
        _activeTime = ActiveTime.end;
      });
      return false;
    }
    Offset globalEndOffset =
    circle.localToGlobal(clockPainter.endHandlerPosition);
    if (globalPoint.dx < globalEndOffset.dx + snap &&
        globalPoint.dx > globalEndOffset.dx - snap &&
        globalPoint.dy < globalEndOffset.dy + snap &&
        globalPoint.dy > globalEndOffset.dy - snap) {
      setState(() {
        _activeTime = ActiveTime.end;
      });
      isHandler = true;
    }
    return isHandler;
  }

  void _panUpdate(PointerMoveEvent ev) {
    if (_activeTime == null) return;
    RenderBox circle =
    _circleKey.currentContext!.findRenderObject() as RenderBox;
    final center = circle.size.center(Offset.zero);
    final point = circle.globalToLocal(ev.position);
    final touchPositionFromCenter = point - center;
    var dir = normalizeAngle(touchPositionFromCenter.direction);

    var minDurationSigned = durationToAngle(widget.minDuration);
    var minDurationAngle =
    minDurationSigned < 0 ? 2 * pi + minDurationSigned : minDurationSigned;

    if (_activeTime == ActiveTime.start) {
      var angleToEndSigned = signedAngle(_endAngle, dir);
      var angleToEnd =
      angleToEndSigned < 0 ? 2 * pi + angleToEndSigned : angleToEndSigned;

      if (widget.disabledTime != null) {
        var angleToDisabledStart = signedAngle(_disabledStartAngle!, dir);
        var angleToDisabledEnd = signedAngle(_disabledEndAngle!, dir);

        var disabledAngleSigned =
        signedAngle(_disabledEndAngle!, _disabledStartAngle!);
        var disabledDiff = disabledAngleSigned < 0
            ? 2 * pi + disabledAngleSigned
            : disabledAngleSigned;

        if (angleToDisabledStart - minDurationAngle < 0 &&
            angleToDisabledStart > -disabledDiff / 2) {
          dir = _disabledStartAngle! - minDurationAngle;
          _updateTimeAndSnapAngle(ActiveTime.end, _disabledStartAngle!);
        } else if (angleToDisabledEnd > 0 &&
            angleToDisabledEnd < disabledDiff / 2) {
          dir = _disabledEndAngle!;
        }
      }

      if (angleToEnd > 0 && angleToEnd < minDurationAngle) {
        var angle = dir + minDurationAngle;
        _updateTimeAndSnapAngle(ActiveTime.end, angle);
      }

      if (widget.maxDuration != null) {
        var startSigned = signedAngle(_endAngle, dir);
        var startDiff = startSigned < 0 ? 2 * pi + startSigned : startSigned;
        var maxSigned = durationToAngle(widget.maxDuration!);
        var maxDiff = maxSigned < 0 ? 2 * pi + maxSigned : maxSigned;
        if (startDiff > maxDiff) {
          var angle = dir + maxSigned;
          _updateTimeAndSnapAngle(ActiveTime.end, angle);
        }
      }
    } else {
      var angleToStartSigned = signedAngle(dir, _startAngle);
      var angleToStart = angleToStartSigned < 0
          ? 2 * pi + angleToStartSigned
          : angleToStartSigned;

      if (widget.disabledTime != null) {
        var angleToDisabledStart = signedAngle(_disabledStartAngle!, dir);
        var angleToDisabledEnd = signedAngle(_disabledEndAngle!, dir);

        var disabledAngleSigned =
        signedAngle(_disabledEndAngle!, _disabledStartAngle!);
        var disabledDiff = disabledAngleSigned < 0
            ? 2 * pi + disabledAngleSigned
            : disabledAngleSigned;

        if (angleToDisabledStart < 0 &&
            angleToDisabledStart > -disabledDiff / 2) {
          dir = _disabledStartAngle!;
        } else if (angleToDisabledEnd + minDurationAngle > 0 &&
            angleToDisabledEnd < disabledDiff / 2) {
          dir = _disabledEndAngle! + minDurationAngle;
          _updateTimeAndSnapAngle(ActiveTime.start, _disabledEndAngle!);
        }
      }

      if (angleToStart > 0 && angleToStart < minDurationAngle) {
        var angle = dir - minDurationAngle;
        _updateTimeAndSnapAngle(ActiveTime.start, angle);
      }

      if (widget.maxDuration != null) {
        var endSigned = signedAngle(dir, _startAngle);
        var endDiff = endSigned < 0 ? 2 * pi + endSigned : endSigned;
        var maxSigned = durationToAngle(widget.maxDuration!);
        var maxDiff = maxSigned < 0 ? 2 * pi + maxSigned : maxSigned;
        if (endDiff > maxDiff) {
          var angle = dir - maxSigned;
          _updateTimeAndSnapAngle(ActiveTime.start, angle);
        }
      }
    }
    _updateTimeAndSnapAngle(_activeTime!, dir);
  }

  _updateTimeAndSnapAngle(ActiveTime type, double angle) {
    var time = _angleToTime(angle - _offsetRad);
    if (time.hour == 24) time = TimeOfDay(hour: 0, minute: time.minute);
    final snapped = widget.snap == true ? timeToAngle(time, -_offsetRad) : angle;
    if (type == ActiveTime.start) {
      setState(() {
        _startAngle = snapped;
        _startTime = time;
      });
      if (widget.onStartChange != null) {
        widget.onStartChange!(_startTime);
      }
    } else {
      setState(() {
        _endAngle = snapped;
        _endTime = time;
      });
      if (widget.onEndChange != null) {
        widget.onEndChange!(_endTime);
      }
    }
  }

  bool isBetweenAngle(double min, double max, double targetAngle) {
    var normalisedMin = min >= 0 ? min : 2 * pi + min;
    var normalisedMax = max >= 0 ? max : 2 * pi + max;
    var normalisedTarget =
    targetAngle >= 0 ? targetAngle : 2 * pi + targetAngle;

    return normalisedMin <= normalisedTarget &&
        normalisedTarget <= normalisedMax;
  }

  void _panEnd(PointerUpEvent ev) => setState(() => _activeTime = null);

  _submit() => Navigator.of(context).pop(
      TimeRange(startTime: _startTime, endTime: _endTime));
  _cancel() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
    MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);

    return OrientationBuilder(
      builder: (_, orientation) => orientation == Orientation.portrait
          ? Column(
        key: _wrapperKey,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (!widget.hideTimes) buildHeader(false),
          Stack(
              alignment: Alignment.center,
              children: [
                if (widget.backgroundWidget != null)
                  widget.backgroundWidget!,
                buildTimeRange(
                    localizations: localizations, themeData: themeData)
              ]),
          if (!widget.hideButtons)
            buildButtonBar(localizations: localizations)
        ],
      )
          : Row(
        children: [
          if (!widget.hideTimes) buildHeader(true),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    key: _wrapperKey,
                    width: double.infinity,
                    child: Stack(alignment: Alignment.center, children: [
                      if (widget.backgroundWidget != null)
                        widget.backgroundWidget!,
                      buildTimeRange(
                          localizations: localizations,
                          themeData: themeData)
                    ]),
                  ),
                ),
                if (!widget.hideButtons)
                  buildButtonBar(localizations: localizations)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonBar({required MaterialLocalizations localizations}) =>
      ButtonBar(
        children: <Widget>[
          TextButton(
            style: widget.buttonStyle,
            onPressed: _cancel,
            child: Text(localizations.cancelButtonLabel),
          ),
          TextButton(
            style: widget.buttonStyle,
            onPressed: _submit,
            child: Text(localizations.okButtonLabel),
          ),
        ],
      );

  Widget buildTimeRange(
      {required MaterialLocalizations localizations,
        required ThemeData themeData}) =>
      RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          ClockGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<ClockGestureRecognizer>(
                () => ClockGestureRecognizer(
                panStart: _panStart, panUpdate: _panUpdate, panEnd: _panEnd),
                (ClockGestureRecognizer instance) {},
          ),
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.white.withOpacity(0),
            child: Center(
              child: CustomPaint(
                key: _circleKey,
                painter: ClockPainter(
                    activeTime: _activeTime,
                    startAngle: _startAngle,
                    endAngle: _endAngle,
                    disabledStartAngle: _disabledStartAngle,
                    disabledEndAngle: _disabledEndAngle,
                    radius: _radius,
                    strokeWidth: widget.strokeWidth,
                    handlerRadius: widget.handlerRadius,
                    strokeColor: widget.strokeColor ?? themeData.primaryColor,
                    handlerColor: widget.handlerColor ?? themeData.primaryColor,
                    selectedColor:
                    widget.selectedColor ?? themeData.primaryColorLight,
                    backgroundColor:
                    widget.backgroundColor ?? Colors.grey.withOpacity(0.3),
                    disabledColor:
                    widget.disabledColor ?? Colors.red.withOpacity(0.5),
                    paintingStyle: widget.paintingStyle,
                    ticks: widget.ticks,
                    ticksColor: widget.ticksColor,
                    ticksLength: widget.ticksLength,
                    ticksWidth: widget.ticksWidth,
                    ticksOffset: widget.ticksOffset,
                    labels: widget.labels ?? List.empty(),
                    labelStyle:
                    widget.labelStyle ?? themeData.textTheme.bodyLarge,
                    labelOffset: widget.labelOffset,
                    rotateLabels: widget.rotateLabels,
                    autoAdjustLabels: widget.autoAdjustLabels,
                    offsetRad: _offsetRad),
                size: Size.fromRadius(_radius),
              ),
            ),
          ),
        ),
      );

  Widget buildHeader(bool landscape) {
    final ThemeData themeData = Theme.of(context);

    Color backgroundColor;
    switch (themeData.brightness) {
      case Brightness.light:
        backgroundColor = widget.timeColor ?? themeData.primaryColor;
        break;
      case Brightness.dark:
        backgroundColor = widget.timeColor ?? themeData.colorScheme.background;
        break;
    }

    Color activeColor;
    Color inactiveColor;
    switch (ThemeData.estimateBrightnessForColor(themeData.primaryColor)) {
      case Brightness.light:
        activeColor = Colors.black87;
        inactiveColor = Colors.black54;
        break;
      case Brightness.dark:
        activeColor = Colors.white;
        inactiveColor = Colors.white70;
        break;
    }

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(24),
      child: Flex(
        direction: landscape ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(widget.fromText, style: TextStyle(color: activeColor)),
              Text(
                MaterialLocalizations.of(context).formatTimeOfDay(_startTime,
                    alwaysUse24HourFormat: widget.use24HourFormat),
                style: _activeTime == ActiveTime.start
                    ? widget.activeTimeTextStyle ??
                    TextStyle(
                        color: activeColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)
                    : widget.timeTextStyle ??
                    TextStyle(
                        color: inactiveColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(children: [
            Text(widget.toText, style: TextStyle(color: activeColor)),
            Text(
              MaterialLocalizations.of(context).formatTimeOfDay(_endTime,
                  alwaysUse24HourFormat: widget.use24HourFormat),
              style: _activeTime == ActiveTime.end
                  ? widget.activeTimeTextStyle ??
                  TextStyle(
                      color: activeColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)
                  : widget.timeTextStyle ??
                  TextStyle(
                      color: inactiveColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
            ),
          ])
        ],
      ),
    );
  }
}

class ClockGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function panStart;
  final Function panUpdate;
  final Function panEnd;
  ClockGestureRecognizer({required this.panStart, required this.panUpdate, required this.panEnd});

  @override
  void addPointer(PointerEvent event) {
    if (panStart(event)) {
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.accepted);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      panUpdate(event);
    }
    if (event is PointerUpEvent) {
      panEnd(event);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}

class ClockPainter extends CustomPainter {
  double? startAngle;
  double? endAngle;
  double? disabledStartAngle;
  double? disabledEndAngle;
  ActiveTime? activeTime;
  double radius;
  double strokeWidth;
  double handlerRadius;
  Color strokeColor;
  Color handlerColor;
  Color selectedColor;
  Color backgroundColor;
  Color disabledColor;
  PaintingStyle paintingStyle;
  Offset? _startHandlerPosition;
  Offset? _endHandlerPosition;
  late TextPainter _textPainter;
  int? ticks;
  double ticksOffset;
  double ticksLength;
  double ticksWidth;
  Color ticksColor;
  List<ClockLabel> labels;
  TextStyle? labelStyle;
  double labelOffset;
  bool rotateLabels;
  bool autoAdjustLabels;
  double offsetRad;
  get startHandlerPosition => _startHandlerPosition;
  get endHandlerPosition => _endHandlerPosition;

  ClockPainter({
    this.startAngle,
    this.endAngle,
    this.disabledStartAngle,
    this.disabledEndAngle,
    this.activeTime,
    required this.radius,
    required this.strokeWidth,
    required this.handlerRadius,
    required this.strokeColor,
    required this.handlerColor,
    required this.selectedColor,
    required this.backgroundColor,
    required this.disabledColor,
    required this.paintingStyle,
    required this.ticks,
    required this.ticksOffset,
    required this.ticksLength,
    required this.ticksWidth,
    required this.ticksColor,
    required this.labels,
    this.labelStyle,
    required this.labelOffset,
    required this.rotateLabels,
    required this.autoAdjustLabels,
    required this.offsetRad,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = paintingStyle
      ..strokeWidth = strokeWidth
      ..color = backgroundColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;
    var rect = Rect.fromLTRB(0, 0, radius * 2, radius * 2);
    canvas.drawCircle(rect.center, radius, paint);
    if (disabledStartAngle != null && disabledEndAngle != null) {
      paint.color = disabledColor;
      var start = normalizeAngle(disabledStartAngle!);
      var end = normalizeAngle(disabledEndAngle!);
      var sweep = calcSweepAngle(start, end);
      canvas.drawArc(rect, start, sweep, paintingStyle == PaintingStyle.fill, paint);
    }
    drawTicks(paint, canvas);
    paint.color = strokeColor;
    paint.strokeWidth = strokeWidth;
    if (startAngle != null && endAngle != null) {
      var start = normalizeAngle(startAngle!);
      var end = normalizeAngle(endAngle!);
      var sweep = calcSweepAngle(start, end);
      canvas.drawArc(rect, start, sweep, paintingStyle == PaintingStyle.fill, paint);
      drawHandler(paint, canvas, ActiveTime.start, start);
      drawHandler(paint, canvas, ActiveTime.end, end);
    }
    drawLabels(paint, canvas);
    canvas.save();
    canvas.restore();
  }

  void drawHandler(Paint paint, Canvas canvas, ActiveTime type, double angle) {
    paint.style = PaintingStyle.fill;
    paint.color = handlerColor;
    if (activeTime == type) {
      paint.color = selectedColor;
    }
    Offset handlerPosition = calcCoords(radius, radius, angle, radius);
    canvas.drawCircle(handlerPosition, handlerRadius, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawCircle(handlerPosition, handlerRadius * 1.5, paint);
    if (type == ActiveTime.start) {
      _startHandlerPosition = handlerPosition;
    } else {
      _endHandlerPosition = handlerPosition;
    }
  }

  void drawTicks(Paint paint, Canvas canvas) {
    var r = radius + ticksOffset - strokeWidth / 2;
    paint.color = ticksColor;
    paint.strokeWidth = ticksWidth;
    for (var i in List.generate(ticks!, (i) => i + 1)) {
      double angle = (360 / ticks!) * i * pi / 180 + offsetRad;
      canvas.drawLine(calcCoords(radius, radius, angle, r),
          calcCoords(radius, radius, angle, r + ticksLength), paint);
    }
  }

  void drawLabels(Paint paint, Canvas canvas) {
    for (var label in labels) {
      drawText(
          canvas,
          paint,
          label.text,
          calcCoords(
              radius, radius, label.angle + offsetRad, radius + labelOffset),
          label.angle + offsetRad);
    }
  }

  void drawText(Canvas canvas, Paint paint, String text, Offset position, double angle) {
    angle = normalizeAngle(angle);
    TextSpan span = TextSpan(
      text: text,
      style: labelStyle,
    );
    _textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
    Offset drawCenter =
    Offset(-(_textPainter.width / 2), -(_textPainter.height / 2));

    if (rotateLabels) {
      bool flipLabel = false;
      if (autoAdjustLabels) {
        if (angle > 0 && angle < pi) {
          flipLabel = true;
        }
      }
      var wordWidth = _textPainter.width;
      var dist = (radius + labelOffset);
      double lengthOffset = 0;
      var chars = !flipLabel ? text.runes : text.runes.toList().reversed;
      for (var char in chars) {
        prepareTextPainter(String.fromCharCode(char));
        final double curveAngle = angle - (wordWidth / 2 - lengthOffset) / dist;
        double letterAngle = curveAngle + pi / 2;
        if (flipLabel) letterAngle = letterAngle + pi;
        final Offset letterPos = calcCoords(radius, radius, curveAngle, dist);
        drawCenter = Offset(flipLabel ? -_textPainter.width : 0, -(_textPainter.height / 2));
        canvas.translate(letterPos.dx, letterPos.dy);
        canvas.rotate(letterAngle);
        _textPainter.paint(canvas, drawCenter);
        canvas.rotate(-letterAngle);
        canvas.translate(-letterPos.dx, -letterPos.dy);
        lengthOffset += _textPainter.width;
      }
    } else {
      _textPainter.paint(canvas, position + drawCenter);
    }
  }

  void prepareTextPainter(String letter) {
    _textPainter.text = TextSpan(text: letter, style: labelStyle);
    _textPainter.layout();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  Offset calcCoords(double cx, double cy, double angle, double radius) {
    double x = cx + radius * cos(angle);
    double y = cy + radius * sin(angle);
    return Offset(x, y);
  }

  double calcSweepAngle(double init, double end) {
    if (end > init) {
      return end - init;
    } else {
      return 2 * pi - (end - init).abs();
    }
  }
}

double normalizeAngle(double radians) {
  var normalized = atan2(sin(radians), cos(radians));
  normalized = normalized > 0 ? normalized : 2 * pi + normalized;
  return normalized;
}

double timeToAngle(TimeOfDay time, double offsetRad) {
  int min = time.hour * 60 + time.minute;
  double angle = min * pi * 2 / 60 / 24;
  return normalizeAngle(angle + pi / 2 + offsetRad);
}

double signedAngle(double startAngle, double targetAngle) {
  return atan2(sin(startAngle - targetAngle), cos(startAngle - targetAngle));
}

double durationToAngle(Duration duration) {
  var min = duration.inMinutes;
  var time = TimeOfDay(hour: min ~/ 60, minute: min % 60);
  return signedAngle(timeToAngle(time, 0), pi / 2);
}

enum ActiveTime { start, end }

class TimeRange {
  TimeOfDay startTime;
  TimeOfDay endTime;
  TimeRange({required this.startTime, required this.endTime});

  @override
  String toString() => "${toStringStart()} às ${toStringEnd()}";
  String toStringStart() => '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  String toStringEnd() => '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
}

class ClockLabel {
  double angle;
  String text;
  ClockLabel({required this.angle, required this.text});

  factory ClockLabel.fromDegree({required double deg, required String text})
   => ClockLabel(angle: deg * pi / 180, text: text);

  factory ClockLabel.fromTime({required TimeOfDay time, required String text}) {
    double angle = timeToAngle(time, 0);
    return ClockLabel(angle: angle, text: text);
  }

  factory ClockLabel.fromIndex({required int idx, required int length, required String text}) {
    double angle = (2 * pi / length) * idx + pi / 2;
    return ClockLabel(angle: angle, text: text);
  }
}
