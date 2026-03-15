import React from "react";
import { Dropdown, MenuProps, Col } from "antd";

interface LogoWithDropdownProps {
    className?: string;
}

const items: Required<MenuProps>["items"] = [
    {
        key: "1",
        label: (
            <a
                href=""
                target="_blank"
                rel="noopener noreferrer"
            >
                Project Page
            </a>
        ),
    },
    {
        key: "2",
        label: (
            <a
                href="https://github.com/sathwikraminedi/DRaffle-Decentralized-Raffle-System"
                target="_blank"
                rel="noopener noreferrer"
            >
                Github
            </a>
        ),
    },
    {
        key: "3",
        label: (
            <a
                href="https://explorer.aptoslabs.com/account/0x791bb225d446fad68fb3aab4da12f8d58561f8291765c13b139e5921a68680e7/modules/view/DRaffle2?network=testnet"
                target="_blank"
                rel="noopener noreferrer"
            >
                Smart Contract
            </a>
        ),
    },
    {
        key: "4",
        label: <hr></hr>,
    },

    {
        key: "4",
        label: (
            <a
                href="
                target="_blank"
                rel="noopener noreferrer"
            >
                About Me
            </a>
        ),
    },
    {
        key: "4",
        label: (
            <a
                href="https://www.linkedin.com/in/sathwik-raminedi-07767131b/"
                target="_blank"
                rel="noopener noreferrer"
            >
                Connect With Me
            </a>
        ),
    },
];

const ProfileDropdown: React.FC<LogoWithDropdownProps> = ({ className }) => {
    return (
        <Col
            flex="200px"
            style={{
                textAlign: "right",
                display: "flex",
                alignItems: "center",
                justifyContent: "flex-end",
                ...(className && { className }),
            }}
        >
            <Dropdown
                menu={{ items }}
                placement="bottomRight"
                trigger={["hover"]}
            >
                <a
                    href="https://www.linkedin.com/in/sathwik-raminedi-07767131b/"
                    target="_blank"
                    rel="noopener noreferrer"
                    onClick={(e: React.MouseEvent<HTMLAnchorElement>) =>
                        e.preventDefault()
                    }
                    style={{
                        textDecoration: "none",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "flex-end",
                    }}
                >
                    <img
                        src="/logo.png"
                        alt="DRaffle Logo"
                        style={{
                            cursor: "pointer",
                            width: "40px",
                            animation: "pulse 1.5s infinite",
                        }}
                    />
                </a>
            </Dropdown>
        </Col>
    );
};

// You might want to add this CSS to your stylesheet
const pulseKeyframes = `
@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.25);
  }
  100% {
    transform: scale(1);
  }
}
`;

// Add this style tag if you haven't defined the pulse animation elsewhere
const styleTag = document.createElement("style");
styleTag.innerHTML = pulseKeyframes;
document.head.appendChild(styleTag);

export default ProfileDropdown;
