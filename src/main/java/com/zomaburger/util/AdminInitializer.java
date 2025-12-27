@Component
public class AdminInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${admin.password:}")
    private String adminPassword;

    @Override
    public void run(String... args) {
        // Create admin only if password is set in environment
        if (adminPassword != null && !adminPassword.isEmpty()) {
            if (!userRepository.existsByUsername("admin")) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(passwordEncoder.encode(adminPassword));
                admin.setEmail("admin@burger.com");
                admin.setRole("ADMIN");
                userRepository.save(admin);
                System.out.println("Admin user created successfully");
            }
        } else {
            System.out.println("⚠️ WARNING: Admin password not set in environment variables!");
        }
    }
}
