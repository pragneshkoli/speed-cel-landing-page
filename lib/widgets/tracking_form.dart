import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TrackingForm extends StatefulWidget {
  final Function(String) onTrackPackage;

  const TrackingForm({Key? key, required this.onTrackPackage}) : super(key: key);

  @override
  _TrackingFormState createState() => _TrackingFormState();
}

class _TrackingFormState extends State<TrackingForm> with SingleTickerProviderStateMixin {
  final _trackingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _trackingController.text = "S-250507-001";
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _trackingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Slight delay to show loading state
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onTrackPackage(_trackingController.text.trim());
        setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      width: isDesktop ? MediaQuery.of(context).size.width * 0.7 : double.infinity,
      margin: EdgeInsets.fromLTRB(
        isDesktop ? MediaQuery.of(context).size.width * 0.15 : (isTablet ? 32.0 : 16.0),
        0,
        isDesktop ? MediaQuery.of(context).size.width * 0.15 : (isTablet ? 32.0 : 16.0),
        isDesktop ? 60.0 : (isTablet ? 50.0 : 40.0),
      ),
      padding: EdgeInsets.all(isDesktop ? 36.0 : (isTablet ? 30.0 : 24.0)),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(isDesktop ? 28.0 : (isTablet ? 24.0 : 20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isDesktop ? 30.0 : (isTablet ? 25.0 : 20.0),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Your Package',
              style: (isDesktop ? theme.textTheme.headlineMedium :
              (isTablet ? theme.textTheme.headlineSmall : theme.textTheme.titleLarge))?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0)),
            Text(
              'Enter your tracking number to get real-time updates',
              style: (isDesktop ? theme.textTheme.titleLarge :
              (isTablet ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium))?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: isDesktop ? 36.0 : (isTablet ? 30.0 : 24.0)),
            isDesktop || isTablet ?
            // Horizontal layout for desktop and tablet
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildTrackingField(theme, isDesktop, isTablet),
                ),
                SizedBox(width: isDesktop ? 24.0 : 16.0),
                Expanded(
                  flex: 3,
                  child: _buildTrackingButton(theme, isDesktop, isTablet),
                ),
              ],
            ) :
            // Vertical layout for mobile
            Column(
              children: [
                _buildTrackingField(theme, isDesktop, isTablet),
                const SizedBox(height: 24),
                _buildTrackingButton(theme, isDesktop, isTablet),
              ],
            ),

            SizedBox(height: isDesktop ? 32.0 : (isTablet ? 24.0 : 16.0)),
            // Hint
            Center(
              child: Text(
                '',
                style: (isDesktop ? theme.textTheme.bodyMedium :
                (isTablet ? theme.textTheme.bodySmall : theme.textTheme.bodySmall))?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingField(ThemeData theme, bool isDesktop, bool isTablet) {
    return TextFormField(
      controller: _trackingController,
      decoration: InputDecoration(
        hintText: 'Enter tracking number',
        prefixIcon: Icon(
          Icons.search,
          color: theme.colorScheme.primary,
          size: isDesktop ? 28.0 : (isTablet ? 24.0 : 20.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 20.0 : (isTablet ? 16.0 : 12.0)),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 20.0 : (isTablet ? 16.0 : 12.0)),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: isDesktop ? 3.0 : 2.0),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(
          vertical: isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0),
          horizontal: isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0),
        ),
      ),
      style: (isDesktop ? theme.textTheme.titleLarge :
      (isTablet ? theme.textTheme.titleMedium : theme.textTheme.bodyLarge)),
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (_) => _submitForm(),
      inputFormatters: [
        // Allow only alphanumeric and - characters
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9-]+$')),
        // Limit to 10 characters
        // LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a tracking number';
        }
        if (value.length < 5) {
          return 'Tracking number must be at least 5 characters';
        }
        return null;
      },
    );
  }

  Widget _buildTrackingButton(ThemeData theme, bool isDesktop, bool isTablet) {
    return MouseRegion(
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        onTap: _isLoading ? null : _submitForm,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: double.infinity,
            height: isDesktop ? 68.0 : (isTablet ? 62.0 : 56.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0)),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimary,
                ),
                strokeWidth: isDesktop ? 4.0 : 3.0,
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_shipping_rounded,
                    color: theme.colorScheme.onPrimary,
                    size: isDesktop ? 28.0 : (isTablet ? 24.0 : 20.0),
                  ),
                  SizedBox(width: isDesktop ? 12.0 : 8.0),
                  Text(
                    'Track Package',
                    style: (isDesktop ? theme.textTheme.titleLarge :
                    (isTablet ? theme.textTheme.titleMedium : theme.textTheme.titleSmall))?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}