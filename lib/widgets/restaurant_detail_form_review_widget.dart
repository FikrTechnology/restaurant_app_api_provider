part of 'widgets_package.dart';

class ReviewForm extends StatefulWidget {
  final RestaurantDetail restaurant;
  final VoidCallback onReviewSubmitted;
  const ReviewForm({super.key, required this.restaurant, required this.onReviewSubmitted});

  @override
  ReviewFormState createState() => ReviewFormState();
}

class ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  String? _responseMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await ApiService().sendReview(
          widget.restaurant.id,
          _nameController.text,
          _reviewController.text,
        );
        setState(() {
          _responseMessage = response.message;
          _nameController.clear();
          _reviewController.clear();

        });
          widget.onReviewSubmitted();
      } catch (e) {
        setState(() {
          _responseMessage = 'Failed to submit review';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Review',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _reviewController,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitReview,
                    child: const Text('Submit Review'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
