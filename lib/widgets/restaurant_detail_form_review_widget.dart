part of 'widgets_package.dart';

class ReviewForm extends StatefulWidget {
  final RestaurantDetail restaurant;
  const ReviewForm({
    super.key,
    required this.restaurant,
  });

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
        final provider = context.read<RestaurantDetailProvider>();
        
        // Panggil provider dan tangkap pesan error (jika ada)
        final String? errorMessage = await provider.fetchReviews(
            widget.restaurant.id, _nameController.text, _reviewController.text);
            
        if (!mounted) return;

        if (errorMessage != null) {
          // Menampilkan dialog apabila ada pesan error (termasuk AI negatif)
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Pesan AI Moderasi'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          );
        } else {
          // Jika errorMessage == null, artinya sukses
          _nameController.clear();
          _reviewController.clear();
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Komentar berhasil ditambahkan!')),
          );
        }
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
                if (_responseMessage != null)
                  Center(
                    child: Text(_responseMessage!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
