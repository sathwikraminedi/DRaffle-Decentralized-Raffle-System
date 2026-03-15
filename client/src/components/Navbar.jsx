import React from "react";
import { Layout, Row, Col, Button, Avatar } from "antd";
import { Wallet, User } from "lucide-react";

const { Header } = Layout;

const Navbar = ({ connected, account, connectWallet, disconnect }) => {
    return (
        <Header
            style={{
                background: "#ADD8E6",
                padding: "0 20px",
                borderRadius: "10px",
                margin: "5px",
            }}
        >
            <Row justify="space-between" align="middle">
                {/* Left side - Logo */}
                <Col flex="200px">
                    <h1
                        style={{
                            margin: 0,
                            fontSize: "30px",
                            fontWeight: "bold",
                        }}
                    >
                        <span
                            style={{
                                color: "#722ed1",
                                backgroundColor: "#f0f5ff",
                                fontSize: "35px",
                                fontWeight: "bold",

                                padding: "0 4px",
                                borderRadius: "4px",
                            }}
                        >
                            D
                        </span>
                        <span
                            style={{
                                color: "#262626",
                                marginLeft: "2px",
                            }}
                        >
                            Raffle
                        </span>
                    </h1>
                </Col>

                {/* Middle - Wallet Connection */}
                <Col flex="auto" style={{ textAlign: "center" }}>
                    {!connected ? (
                        <Button
                            type="primary"
                            onClick={connectWallet}
                            icon={<Wallet className="mr-2" size={16} />}
                            size="large"
                        >
                            Connect Petra Wallet
                        </Button>
                    ) : (
                        <Button
                            onClick={disconnect}
                            icon={<Wallet className="mr-2" size={16} />}
                            size="large"
                        >
                            {account?.address?.slice(0, 6)}...
                            {account?.address?.slice(-4)}
                        </Button>
                    )}
                </Col>

                {/* Right side - User Avatar */}
                <Col flex="200px" style={{ textAlign: "right" }}>
                    <Avatar
                        size={40}
                        icon={<User size={24} />}
                        style={{
                            backgroundColor: "#1890ff",
                            cursor: "pointer",
                        }}
                    />
                </Col>
            </Row>
        </Header>
    );
};

export default Navbar;
