import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/theme/controller/theme_controller.dart';
import '../../portfolio/provider/portfolio_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = context.watch<PortfolioProvider>();
    final themeController = context.read<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Green Portfolio Dashboard"),
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkTheme
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: portfolioProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await portfolioProvider.refreshPortfolio();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ===============================
                    /// SUMMARY CARDS
                    /// ===============================
                    _buildSummaryCard(
                      title: "Total Portfolio Value",
                      value:
                          "\$${portfolioProvider.totalValue.toStringAsFixed(2)}",
                      icon: Icons.account_balance_wallet,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 16),

                    _buildSummaryCard(
                      title: "Total CO₂ Impact",
                      value:
                          "${portfolioProvider.totalCarbon.toStringAsFixed(2)} kg",
                      icon: Icons.cloud,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    _buildSummaryCard(
                      title: "Green Score",
                      value:
                          "${portfolioProvider.greenScore.toStringAsFixed(1)}%",
                      icon: Icons.eco,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Your Stocks",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    /// ===============================
                    /// STOCK LIST
                    /// ===============================
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: portfolioProvider.stocks.length,
                      itemBuilder: (context, index) {
                        final stock =
                            portfolioProvider.stocks[index];

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(stock.symbol),
                            subtitle: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Price: \$${stock.price.toStringAsFixed(2)}"),
                                Text(
                                    "ESG Score: ${stock.esgScore.toStringAsFixed(1)}"),
                                Text(
                                    "CO₂: ${stock.co2Emission.toStringAsFixed(2)} kg"),
                              ],
                            ),
                            trailing: Text(
                              "\$${stock.totalValue.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

      /// ===============================
      /// ADD STOCK BUTTON
      /// ===============================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStockDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// ===============================
  /// SUMMARY CARD WIDGET
  /// ===============================
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================
  /// ADD STOCK DIALOG
  /// ===============================
  void _showAddStockDialog(BuildContext context) {
    final TextEditingController controller =
        TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Stock"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter stock symbol (e.g. AAPL)",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  await context
                      .read<PortfolioProvider>()
                      .loadStock(controller.text.trim());
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
